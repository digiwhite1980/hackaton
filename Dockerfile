FROM mcr.microsoft.com/azure-cli as base
# -----------------------------------------------------------------------------
FROM base as tools

ENV WORKDIR=/tools
ENV KUBECTL_VERSION=1.15.8
ENV HELM_VERSION=2.14.2

RUN mkdir ${WORKDIR}
WORKDIR ${WORKDIR}
# ---------------------------- kubectl 
RUN curl -L -o kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl

# ---------------------------- helm 
RUN curl -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar zxf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
	 mv linux-amd64/helm . && \
	 rm -fr linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz

# ---------------------------- kubectx 
RUN git clone https://github.com/ahmetb/kubectx.git kubectx_repo && \
    mv kubectx_repo/kubectx . && \
	 mv kubectx_repo/kubens . && \
	 rm -fr kubectx_repo

# ---------------------------- kube-prompt 
RUN apk update && \
    apk add go
RUN git clone https://github.com/c-bata/kube-prompt.git kube-prompt-repo && \
    cd kube-prompt-repo && \
 	 make build && \
	 cp kube-prompt ${WORKDIR} && \
	 cd - && \
	 rm -fr kube-prompt-repo

RUN chmod 755 *

RUN apk add bash-completion ncurses
# -----------------------------------------------------------------------------
FROM base

ENV HOSTNAME=hackaton

COPY --from=tools /tools /usr/local/bin
COPY --from=tools /etc/profile.d/bash_completion.sh /etc/profile.d
COPY --from=tools /usr/share/bash-completion/bash_completion /usr/share/bash-completion/bash_completion
COPY --from=tools /usr/bin/tput /usr/bin
COPY bash_prompt.sh /etc/profile.d/bash_prompt.sh

RUN echo "Europe/Amsterdam" >> /etc/timezone && \
    echo "source <(kubectl completion bash)" > /etc/profile.d/kube_completion.sh

CMD [ "/bin/bash", "--init-file", "/etc/profile" ]
