# Microsoft ING hackaton repo
This repo is intended to meet the minimal requirements for running the MS hackaton
Ensure the following software is available on your computer / laptop
- docker
- docker-compose

## Build ING hackaton environment
```
docker-compose run --service-ports hackaton
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

## Source folder in container
In order to dettach data from your docker container a /source folder is mounted into the docker container. 
This folder maps to a folder in your current working directory: ./data/source.
There is another folder ./data/root. this folder holds your local bash_history as well as the current token for the azure CLI.


