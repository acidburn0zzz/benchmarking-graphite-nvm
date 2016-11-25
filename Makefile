all: help

help:
	@echo "apply or destroy"

apply:
	time terraform apply
destroy:
	time terraform destroy
