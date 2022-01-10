#!/bin/bash
#
# This script will build the VM Image needed to run peertube
# It will be placed in the active project
# Requires: gcloud
#

for i in "gcloud"; do
  command -v "${i}" 2>&1 > /dev/null || { echo >&2 "${i} is not installed."; echo "${MESSAGE}"; exit 1; }
done

# Set Variables
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=`gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)"`
source config.sh

# Print Help + Project Confirmation
echo $""
echo $"* * * * * * * * * * * * * * * * * * * * * * "
echo "Please ensure the following before you begin:
 - You have 'gcloud' installed (https://cloud.google.com/sdk/docs/install) and authenticated (https://cloud.google.com/sdk/docs/initializing).
 - You have created a new project with billing enabled, and have permissions of 'roles/owner'.
 - You have set the project using 'gcloud config set project PROJECT_ID'."
echo $"* * * * * * * * * * * * * * * * * * * * * * "
echo $""
read -n 1 -p "Build image for PROJECT_ID: ${PROJECT_ID}, would you like to continue? (y/N) " REPLY
echo

# Check Project ID
if [[ ! ${REPLY} =~ ^[Yy]$ ]]; then
  [[ "$0" = "${BASH_SOURCE}" ]] && exit 1 || return 1
else
  # Enable Services
  gcloud services enable sourcerepo.googleapis.com
  gcloud services enable compute.googleapis.com
  gcloud services enable servicemanagement.googleapis.com
  gcloud services enable storage-api.googleapis.com
  gcloud services enable iamcredentials.googleapis.com

  # Set Permissions
  gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:$(gcloud projects describe ${PROJECT_ID} --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com --role roles/owner
  gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:$(gcloud projects describe ${PROJECT_ID} --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com --role roles/compute.instanceAdmin
  
  # Create PACKER service account
  gcloud iam service-accounts create packer --description "Packer image builder"
  gcloud projects add-iam-policy-binding $PROJECT_ID --role="roles/compute.instanceAdmin.v1" --member="serviceAccount:packer@${PROJECT_ID}.iam.gserviceaccount.com"
  gcloud projects add-iam-policy-binding $PROJECT_ID --role="roles/iam.serviceAccountUser" --member="serviceAccount:packer@${PROJECT_ID}.iam.gserviceaccount.com"
  gcloud iam service-accounts add-iam-policy-binding packer@${PROJECT_ID}.iam.gserviceaccount.com --role="roles/iam.serviceAccountTokenCreator" --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"

  # Submit Build
  gcloud builds submit --config "image/cloudbuild.yaml" --timeout=1200s "image"
fi