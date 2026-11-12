# Infra code

This repository contains a Terraform-based Azure dev environment for deploying five Linux virtual machines in a single region using secure, parameterized infrastructure patterns.

## Layout

- `aks/terraform/` — Terraform root module
- `aks/terraform/modules/network/` — VNet, subnet, and NSG configuration
- `aks/terraform/modules/compute/` — VM NIC and Linux VM configuration
- `aks/terraform/environments/dev/terraform.tfvars.example` — example values for a single-region dev deployment

## Industry-standard practices included

- One resource group and one region for the dev environment
- No hard-coded Azure region values in the module logic
- Secure default networking with NSG rules limited to admin CIDR ranges
- Optional public IPs disabled by default to reduce exposure
- Tagging for ownership, workload, and environment
- Reusable modules with variables instead of embedded values

## Deploying the dev environment

1. Copy the example variables file:
   `cp aks/terraform/environments/dev/terraform.tfvars.example aks/terraform/environments/dev/terraform.tfvars`
2. Replace the placeholder subscription ID, SSH key, and admin CIDR values.
3. From the Terraform directory, run:
   `terraform init`
   `terraform plan -var-file="environments/dev/terraform.tfvars"`
   `terraform apply -var-file="environments/dev/terraform.tfvars"`

## Notes

- Keep `public_ip_enabled = false` unless direct inbound access is required.
- Use a restricted admin CIDR such as your corporate VPN or office IP.
- This setup is designed for a development workload and does not include multi-region redundancy or production compliance controls.
