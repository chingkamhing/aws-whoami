.PHONY: help
help:
	@echo "Usage:"
	@echo "Makefile commands"
	@echo "    user-info            Get AWS user info"
	@echo "    fmt                  Terraform format all the files"
	@echo "    validate             Validate terraform configuration"
	@echo "    init                 Initializing terraform configuration directory downloads and installs the providers"
	@echo "    plan                 Preview the changes that Terraform plans to make to your infrastructure"
	@echo "    apply                Apply the terraform infrastructure"
	@echo "    show                 Inspect the current terraform state"
	@echo "    output               Prints terraform output values"
	@echo "    destroy              Destroy the terraform infrastructure"

#
# Makefile commands
#

.PHONY: user-info
user-info:
	aws sts get-caller-identity

.PHONY: fmt
fmt:
	terraform fmt

.PHONY: validate
validate:
	terraform validate

.PHONY: init
init:
	terraform init

.PHONY: plan
plan: 
	terraform plan

.PHONY: apply
apply: 
	terraform apply

.PHONY: show
show:
	terraform show

.PHONY: output
output:
	terraform output

.PHONY: destroy
destroy:
	terraform destroy
