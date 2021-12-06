prepare-deployment:
	(echo "cat <<EOF"; cat ./infra/deployment.tfvars; echo "EOF") \
		| bash \
		| tee ./infra/deployment.auto.tfvars

terraform-init:
	cd ./infra && \
	terraform-init

terraform-validate:
	cd ./infra && \
	terraform validate -no-color

terraform-plan:
	cd ./infra && \
	terraform plan \
		-no-color

terraform-apply:
	cd ./infra && \
	terraform apply \
		-auto-approve
