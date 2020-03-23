variable "iaas_classic_username" {
    default = "IBM15xxxxxx"
}

variable "iaas_classic_api_key" {
    default = "f1c357b839d8090f4b94f9001cc0f6c61b84eae0a936bxxxxxxxxxxxxxxxxxxx"
}

variable "ibmcloud_api_key" {
    default = "9NUevejrdi9joHaaxGrEbLxxxxxxxxxxxxxxxxxxxxxx"
}

variable "appli_name" {
  type        = "string"
  description = "Name of the Application (e.g. AP12345) to create the AG/RG accordingly"
}

variable "email_ADM_list" {
  type        = "list"
  description = "List of the emails to invite to the ADMIN Access Group"
  default = []
}

variable "email_DEV_list" {
  type        = "list"
  description = "List of the emails to invite to the DEV Access Group"
  default = []
}

variable "services_list_InsideRG_PlatformServices" {
  type        = "list"
  description = "List of the IBM Cloud Service ID (not name) where Platform & Services Access needed"
  default = ["appid","kms","internet-svcs","sysdig-monitor"]
}

variable "services_list_InsideRG_PlatformOnly" {
  type        = "list"
  description = "List of the IBM Cloud Service ID (not Name) where only Platform Access needed"
  default = ["databases-for-postgresql","databases-for-mongodb"]
}



variable "services_list_OutsideRG_PlatformServices" {
  type        = "list"
  description = "List of the IBM Cloud Service ID (not Name) defined outside the ResourceGroup"
  default = ["schematics","container-registry","containers-kubernetes","continuous-delivery"]
}

variable "services_list_OutsideRG_PlatformOnly" {
  type        = "list"
  description = "List of the IBM Cloud Service ID (not Name) defined outside the ResourceGroup"
  default = ["support","toolchain","is"]
}


variable "services_list_logDNA" {
  type        = "list"
  description = "List of the IBM LOGDNA services"
  default = ["logdna","logdnaat"]
}



variable "privs_PlatformServices_Adm" {
  type        = "list"
  description = "List of the IBM Cloud privileges for ADMIN AG"
  default = ["Administrator","Editor","Operator","Manager","Writer"]
}

variable "privs_PlatformServices_Dev" {
  type        = "list"
  description = "List of the IBM Cloud privileges for DEV AG"
  default = ["Viewer","Writer"]
}



variable "privs_PlatformOnly_Adm" {
  type        = "list"
  description = "List of the IBM Cloud privileges for ADMIN AG"
  default = ["Administrator", "Editor","Operator","Viewer"]
}

variable "privs_PlatformOnly_Dev" {
  type        = "list"
  description = "List of the IBM Cloud privileges for DEV AG"
  default = ["Operator","Viewer"]
}


variable "privs_logDNA_Adm" {
  type        = "list"
  description = "List of the LOGDNA for ADMIN AG"
  default = ["Administrator","Editor","Operator","Manager","Viewer","Reader"]
}

variable "privs_logDNA_Dev" {
  type        = "list"
  description = "List of the LOGDNA privileges for DEV AG"
  default = ["Viewer","Reader"]
}
