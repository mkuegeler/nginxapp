# nginxapp
This repository provides a simple web app based on **nginx:alpine**.  It runs in a Docker container or a Kubernetes cluster. The initial version comes with just one static "index.html" file in the the "/app" folder. The first section of the script defines global variables used in the script.

````bash
# 1. Set variables
REPO="mkuegeler/nginxapp:latest"
IMAGE="nginx-alpine-image"
CONTAINER="nginx-alpine-container"
HOST="localhost"
INTERNAL_PORT="80"
EXTERNAL_PORT="8081"
````

You can customize the values. 

## Running the app in simple Docker container.
The script "app.sh" provides common Docker commands. Type "./app.sh" for help.

## Running the application on Kubernetes
Requirements
 - A Kubernetes cluster (i.e. Docker Desktop)
 - Helm

### 1. Create a helm chart

```bash
helm create nx-example
```
Note: you can use a custom name instead of 'nx-example'.

### 2. Customize values.yaml 
Open the file "values.yaml" in directory "nx-example".

In "values.yaml", update the image keys to reference the nginx image: 

```yaml
image:
  repository: mkuegeler/nginxapp
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: "latest"
```

### 4. Validate the chart
 Run the chart through the linter to ensure that your template is well-formed. 

````bash
helm lint ./nx-example
````

### 3. Install chart
Run "helm install" to deploy the application:

````bash
helm install nx-example ./nginxweb --set service.type=NodePort
````

The output of helm install displays a handy summary of the state of the release, what objects were created, and the rendered NOTES.txt file to explain what to do next. Run the commands in the output to get a URL to access the service and pull it up in your browser.

````bash
NAME: nx-example
LAST DEPLOYED: Tue Sep  8 13:38:14 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services nx-example-nginxweb)
  export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
````

### 4. Run the application
 Run the commands in the NOTES to get a URL to access our application.

````bash
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services nx-example-nginxweb)
````

````bash
export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
````

````bash
echo http://$NODE_IP:$NODE_PORT
````

### 5. Delete the service
if you want to delete the service, type:

````bash
helm delete nx-example
````

