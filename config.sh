# Project Constants
export REGION="australia-southeast1"
export LOCATION="australia-southeast1"
export ZONE="australia-southeast1-a"
export TERRAFORM_STATE_BUCKET="terraform-state"


# VM Image Constants
export VM_IMAGE_NAME="peertube-vm-image"
export VM_IMAGE_DESCRIPTION="Peertube VM Image"
export VM_IMAGE_LABEL="peertube-vm-image"
export VM_IMAGE_FAMILY="peertube-vm-image"
export VM_IMAGE_PROJECT="peertube-vm-image"
export VM_IMAGE_SOURCE_URL="https://source.developers.google.com/projects/peertube-vm-image/repos/peertube-vm-image/moveable-aliases/master"
export VM_IMAGE_SOURCE_TAG="latest"
export VM_IMAGE_SOURCE_TYPE="GIT"


# Terraform Mappings
export TF_VAR_project_id="${PROJECT_ID}"
export TF_VAR_region="${REGION}"
export TF_VAR_location="${LOCATION}"
export TF_VAR_zone="${ZONE}"
export TF_VAR_terraform_state_bucket="${TERRAFORM_STATE_BUCKET}"
export TF_VAR_vm_image_name="${VM_IMAGE_NAME}"
export TF_VAR_vm_image_description="${VM_IMAGE_DESCRIPTION}"
export TF_VAR_vm_image_label="${VM_IMAGE_LABEL}"
export TF_VAR_vm_image_family="${VM_IMAGE_FAMILY}"
export TF_VAR_vm_image_project="${VM_IMAGE_PROJECT}"
export TF_VAR_vm_image_source_url="${VM_IMAGE_SOURCE_URL}"
export TF_VAR_vm_image_source_tag="${VM_IMAGE_SOURCE_TAG}"
export TF_VAR_vm_image_source_type="${VM_IMAGE_SOURCE_TYPE}"





