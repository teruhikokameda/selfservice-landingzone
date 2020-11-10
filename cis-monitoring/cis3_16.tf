/* locals {
     date_created = {for k, v in data.oci_kms_keys.these.keys : k.displayName => {"year"= split(":",k.time_created)[0],"month"= split(":",k.time_created)[1],"day"= split(":",k.time_created)[2]}}
}
output "keys_requiring_rotation" {
    # value = [for k in data.oci_kms_keys.these.keys : "Please rotate key ${k.display_name}." 
    #            if timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ",k.time_created),"8760h") < timeadd(timestamp(),"0h")
    #        ] 
    value = local.date_created        
}  
*/

terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = "0.6.0"
    }
  }
}
/*
output "key_time_created" {
    #value = time_offset.time_created.unix
    value = data.oci_kms_keys.these.keys[0].time_created
}    


data "oci_kms_keys" "these" {
    compartment_id      = data.terraform_remote_state.iam.outputs.security_compartment_id
    management_endpoint = "https://bbp2f47gaacuu-management.kms.${var.region}.oraclecloud.com/20180608/keys"
}
*/
output "key_time_created" {
    #value = time_offset.time_created.unix
    value = time_rotating.this.rotation_rfc3339
} 
resource "time_rotating" "this" {
    rotation_days = 365
}    