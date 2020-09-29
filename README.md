# Microsoft ING hackaton repo
This repo is intended to meet the minimal requirements for running the MS hackaton
Ensure the following software is available on your computer / laptop
- docker
- docker-compose

## Build ING hackaton environment
```
docker-compose run --service-ports hackaton
```
If you change the Dockerfile to meet your personal preferences don't forget to rebuild the image:
```
docker-compose build
```

## Azure CLI login
After starting the container you need to login into wiith the Azure CLI. to do so enter the following command:
```
# az login
> To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code DF6VRNKU5 to authenticate.
```
Go to the given page and enter your private code 
The page will redirect to the login page. Provide your ING credentials.
After a succesfull login the container will display all attached subscriptions
Test your account with the following command
```
az account show
```
If you have multiple subscription make sure to set / activate the right subscription. 
```
az account list -o table
az account set -s {subscriptionId}
az account list -o table # Check the last column to see if the IsDefault flag is set
```

## Source folder in container
In order to dettach data from your docker container a /source folder is mounted into the docker container. 
This folder maps to a folder in your current working directory: ./data/source.
There is another folder ./data/root. this folder holds your local bash_history as well as the current token for the azure CLI.

## kube-prompt / bash-completion / kubens and kubectx
kube-propmt is an interactive shell which has full completion of kubernetes cli commands.
```
# kube-prompt
```
Before using kube-prompt make sure you have a kubeconfig configured. You can retreive a kubeconfig by running
the following command (a kubernetes cluster needs to be available):
```
az aks get-credentials -n {aks clustername} -g {resourcegroup name}
```
Besides that, bash completion for kubectl is also included.

kubens and kubectx are also included.
- kubens (for switching between default namespace)
- kubectx (for switching between different kubernetes context)
