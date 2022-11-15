

#---------------------------------
# optionals - with defaults
#---------------------------------


#
# cloudtrail configuration
#
variable "cloudtrail_sns_arn" {
  type        = string
  default     = "create"
  description = "ARN of a pre-existing cloudtrail_sns. If defaulted, a new cloudtrail will be created. ARN of a pre-existing cloudtrail_sns. If defaulted, a new cloudtrail will be created. If specified, sysdig deployment account and region must match with the specified SNS"
}

variable "cloudtrail_is_multi_region_trail" {
  type        = bool
  default     = true
  description = "true/false whether cloudtrail will ingest multiregional events"
}

variable "cloudtrail_kms_enable" {
  type        = bool
  default     = true
  description = "true/false whether cloudtrail delivered events to S3 should persist encrypted"
}

#
# benchmark configuration
#

#
# trust-relationship configuration
#
variable "role_name" {
  type        = string
  description = "Role name for cspm"
  default     = "sfc-cspm-role"
}

variable "trusted_identity" {
  type        = string
  description = "The name of sysdig trusted identity"
}

variable "external_id" {
  type        = string
  description = "Random string generated unique to a customer"
}

#
# general
#

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "sfc"
}

variable "tags" {
  type        = map(string)
  description = "sysdig secure-for-cloud tags. always include 'product' default tag for resource-group proper functioning"
  default = {
    "product" = "sysdig-secure-for-cloud"
  }
}

########
variable "cloudconnector_ecr_image_uri" {
  type        = string
  description = "URI to cloudconnectors image on ECR"
  default     = "public.ecr.aws/o5x4u2t4/cloud-connector:latest"
}
