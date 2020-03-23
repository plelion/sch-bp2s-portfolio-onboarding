## Version & Constants
terraform {
  required_version = "> 0.8.0"
}

data "ibm_resource_quota" "myquota" {
  name = "Pay-as-you-go Quota"
}

## access group concepts are available since ibm tf provider v0.12
provider "ibm" {
  version = ">= 0.12.0"
  region = "eu-de"
  iaas_classic_username = "${var.iaas_classic_username}"
  iaas_classic_api_key  = "${var.iaas_classic_api_key}"
  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
}

## using appli_name as ressourcegroup
resource "ibm_resource_group" "rg" {
  name     = "${var.appli_name}"
}

## TL access groups
resource "ibm_iam_access_group" "ag_adm" {
  name = "${var.appli_name}_ADM"
  description = "Application/Project ${var.appli_name} - Access with ADMinistrator privileges"
}

## DV access groups
resource "ibm_iam_access_group" "ag_dev" {
  name = "${var.appli_name}_DEV"
  description = "Application/Project ${var.appli_name} - Access with DEVelopper privileges"
}


## Set of policies where Platform and Services privs are needed for the AG ADMIN&DEV (Inside RG)
resource "ibm_iam_access_group_policy" "adm_inside_ps_rg" {
  count = "${length(var.services_list_InsideRG_PlatformServices)}"
  access_group_id = "${ibm_iam_access_group.ag_adm.id}"
  roles        = "${var.privs_PlatformServices_Adm}"

  resources = [
     {
      service = "${element(var.services_list_InsideRG_PlatformServices, count.index)}"
      resource_group_id = "${ibm_resource_group.rg.id}"
     }
  ]
}

resource "ibm_iam_access_group_policy" "dev_inside_ps_rg" {
  count = "${length(var.services_list_InsideRG_PlatformServices)}"
  access_group_id = "${ibm_iam_access_group.ag_dev.id}"
  roles        = "${var.privs_PlatformServices_Dev}"

  resources = [
    {
      service = "${element(var.services_list_InsideRG_PlatformServices, count.index)}"
      resource_group_id = "${ibm_resource_group.rg.id}"
    }
  ]
}


## Set of policies where only Platform privs is needed for the AG ADMIN&DEV (Inside RG)
resource "ibm_iam_access_group_policy" "adm_inside_p_rg" {
  count = "${length(var.services_list_InsideRG_PlatformOnly)}"
  access_group_id = "${ibm_iam_access_group.ag_adm.id}"
  roles        = "${var.privs_PlatformOnly_Adm}"

  resources = [
     {
      service = "${element(var.services_list_InsideRG_PlatformOnly, count.index)}"
      resource_group_id = "${ibm_resource_group.rg.id}"
     }
  ]
}

resource "ibm_iam_access_group_policy" "dev_inside_p_rg" {
  count = "${length(var.services_list_InsideRG_PlatformOnly)}"
  access_group_id = "${ibm_iam_access_group.ag_dev.id}"
  roles        = "${var.privs_PlatformOnly_Dev}"

  resources = [
    {
      service = "${element(var.services_list_InsideRG_PlatformOnly, count.index)}"
      resource_group_id = "${ibm_resource_group.rg.id}"
    }
  ]
}


## Set of policies for LOGDNA for the AG ADMIN&DEV (Inside RG)
resource "ibm_iam_access_group_policy" "adm_inside_log_rg" {
  count = "${length(var.services_list_logDNA)}"
  access_group_id = "${ibm_iam_access_group.ag_adm.id}"
  roles        = "${var.privs_logDNA_Adm}"

  resources = [
     {
      service = "${element(var.services_list_logDNA, count.index)}"
      resource_group_id = "${ibm_resource_group.rg.id}"
     }
  ]
}

resource "ibm_iam_access_group_policy" "dev_inside_log_rg" {
  count = "${length(var.services_list_logDNA)}"
  access_group_id = "${ibm_iam_access_group.ag_dev.id}"
  roles        = "${var.privs_logDNA_Dev}"

  resources = [
    {
      service = "${element(var.services_list_logDNA, count.index)}"
      resource_group_id = "${ibm_resource_group.rg.id}"
    }
  ]
}



## Set of policies where Platform and Services privs are needed for the AG ADMIN&DEV (outside RG)
resource "ibm_iam_access_group_policy" "adm_outside_ps_rg" {
  count = "${length(var.services_list_OutsideRG_PlatformServices)}"
  access_group_id = "${ibm_iam_access_group.ag_adm.id}"
  roles        = "${var.privs_PlatformServices_Adm}"

  resources = [
     {
      service = "${element(var.services_list_OutsideRG_PlatformServices, count.index)}"
     }
  ]
}

resource "ibm_iam_access_group_policy" "dev_outside_ps_rg" {
  count = "${length(var.services_list_OutsideRG_PlatformServices)}"
  access_group_id = "${ibm_iam_access_group.ag_dev.id}"
  roles        = "${var.privs_PlatformServices_Dev}"

  resources = [
     {
      service = "${element(var.services_list_OutsideRG_PlatformServices, count.index)}"
     }
  ]
}


## Set of policies where only Platform privs are needed for the AG ADMIN&DEV (outside RG)
resource "ibm_iam_access_group_policy" "adm_inside_s_rg" {
  count = "${length(var.services_list_OutsideRG_PlatformOnly)}"
  access_group_id = "${ibm_iam_access_group.ag_adm.id}"
  roles        = "${var.privs_PlatformOnly_Adm}"

  resources = [
     {
      service = "${element(var.services_list_OutsideRG_PlatformOnly, count.index)}"
     }
  ]
}

resource "ibm_iam_access_group_policy" "dev_inside_s_rg" {
  count = "${length(var.services_list_OutsideRG_PlatformOnly)}"
  access_group_id = "${ibm_iam_access_group.ag_dev.id}"
  roles        = "${var.privs_PlatformOnly_Dev}"

  resources = [
     {
      service = "${element(var.services_list_OutsideRG_PlatformOnly, count.index)}"
     }
  ]
}

## Invite the emails to the "access group" resources for the ADM and DEV
resource "ibm_iam_access_group_members" "adm_email"
{
  count = "${length(var.email_ADM_list) == 0 ? 0 : 1}"
  access_group_id = "${ibm_iam_access_group.ag_adm.id}"
  ibm_ids         = "${var.email_ADM_list}"
}

resource "ibm_iam_access_group_members" "dev_email"
{
  count = "${length(var.email_DEV_list) == 0 ? 0 : 1}"
  access_group_id = "${ibm_iam_access_group.ag_dev.id}"
  ibm_ids         = "${var.email_DEV_list}"
}
