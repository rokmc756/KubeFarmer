# Log in to Azure
az login

# Create an ACR if you don't have one
az acr create --resource-group <your-resource-group> --name <your-registry-name> --sku Basic

# Log in to the ACR
az acr login --name <your-registry-name>

# Tag the Docker image with the ACR login server name
docker tag mydockerhub/llm:latest <your-registry-name>.azurecr.io/llm:latest

# Push the Docker image to ACR
docker push <your-registry-name>.azurecr.io/llm:latest

