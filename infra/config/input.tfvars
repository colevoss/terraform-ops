# ======================================
# DOCS
# ======================================
# This file contains the variables values for each resource needed. If you want to use a value other
# than the default value, uncomment the variable and set it here.
#
# ======================================
# ENVIRONMENT SET VARIABLES
# ======================================
# If a variable needs to be set by an environment variable, set the variable in the infra/config/env.tfvars.template
# file and set the value to ${ENV_VARIABLE_NAME} (wrap in double quotes if string) and comment the variable out here.
# 
# ======================================
# VARIABLES FOR SPECIFIC ENVIRONMENT
# ======================================
# If a variable does not need to be set by ENV variables but should be set independently for each type
# of environment (staging/production) move the variable to the infra/config/<environment name>/config.tfvars file
# and comment it out here.

# ======================================
# Service Variables
# ======================================

# Set in env.tfvars.template by environment variables
# gcp_project_id   = "${GOOGLE_PROJECT_ID}"
# gcp_region       = "${GCP_REGION}"

# ======================================
# Service Variables
# ======================================

service_name = "my-service"
# service_image = "${MY_SERVICE_IMAGE}" # Set in env.tfvars.template by environment

# service_min_instances = # Defaulted
# service_max_instances = # Defaulted
# service_cpu_limit = # Defaulted
# service_memory_limit = # Defaulted

# ======================================
# Database Variables
# ======================================


database_name = "my-postgres-db"
database_tier = "db-f1-micro"

# These should probably go in the env.tfvars file to be injected from the environment
database_user_name = "me"
database_password  = "mydbpassword"

# ======================================
# Cache Variables
# ======================================

cache_name           = "my-redis-cache"
cache_tier           = "BASIC"
cache_display_name   = "My Redis Cache"
cache_memory_size_gb = 1
