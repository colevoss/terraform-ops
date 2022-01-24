# Inject environment variables into the `deployment.tfvars.template` file and
# write the output to `infra/deployment.auto.tfvars` so it will be automatically
# used as terraform variables
prepare-deployment:
	(echo "cat <<EOF"; cat ./infra/config/env.tfvars.template; echo "EOF") \
		| bash \
		| tee ./infra/env.auto.tfvars

terraform-init:
	cd ./infra && \
	terraform init \
		-backend-config=./config/${ENV}/gcs.tfbackend

ENV?=staging

terraform-validate:
	cd ./infra && \
	terraform validate -no-color

terraform-plan:
	cd ./infra && \
	terraform plan \
		-no-color \
		-var-file=./config/${ENV}/config.tfvars \
		-var-file=./config/input.tfvars

terraform-apply:
	cd ./infra && \
	terraform apply \
		-auto-approve \
		-var-file=./config/${ENV}/config.tfvars \
		-var-file=./config/input.tfvars