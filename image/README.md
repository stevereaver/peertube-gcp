__Creating a Packer builder image__

The build image for packer must be set up for for the project you are creating the peertube instance in. Cloud Build provides a Packer community builder image that you can use to invoke packer commands in Cloud Build. Before using this builder in a Cloud Build config file, you must build the image and push it to the Container Registry in your project:

Clone the cloud-builders-community repository:

```git clone https://github.com/GoogleCloudPlatform/cloud-builders-community.git```

Navigate to the Packer builder image:

```cd cloud-builders-community/packer```

Submit the builder to your project:

```gcloud builds submit .```