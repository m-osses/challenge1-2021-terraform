.PHONY: console

.ONESHELL:

SHELL = /bin/bash

PROJECT_ROOT := $(shell while /bin/true ; do if [ -e .git ]; then  pwd ; exit 0 ; fi ; cd .. ; if [ "$$(pwd)" = "/" ] ; then exit 1 ; fi ; done)
TF_DATA_DIR ?= .terraform
VARIABLE_FILE_NAME := $(shell cat config.json | jq -r .vars_file_name)

PROJECT_ENV := $(shell cat $(PROJECT_ROOT)/$(VARIABLE_FILE_NAME) | jq -r .env )

ifeq (,$(PROJECT_ENV))
$(error env not set in $(PROJECT_ROOT)/$(VARIABLE_FILE_NAME))
endif


PROJECT_ID := $(shell cat $(PROJECT_ROOT)/$(VARIABLE_FILE_NAME) | jq -r .project_id )

ifeq (,$(PROJECT_ID))
$(error project_id not set in $(PROJECT_ROOT)/$(VARIABLE_FILE_NAME))
endif



TF_BUCKET := $(shell cat $(PROJECT_ROOT)/$(VARIABLE_FILE_NAME) | jq -r .tf_state_bucket_name )

ifeq (,$(TF_BUCKET))
$(error tf_state_bucket_name not set in $(PROJECT_ROOT)/$(VARIABLE_FILE_NAME))
endif

USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

DOCKER := docker run -ti --rm \
	-e TF_DATA_DIR=$(TF_DATA_DIR) \
	-u $(USER_ID):$(GROUP_ID) \
	-e TF_LOG \
	--mount type=bind,source=$(PROJECT_ROOT),target=/docker-tf \
	--workdir /docker-tf/project-init/$(PROJECT_ENV)

TERRAFORM_DOCKER_IMAGE := hashicorp/terraform:0.12.31

OPTS_GLOBALS_VARS := \
	-var-file=/docker-tf/$(VARIABLE_FILE_NAME)


# --- targets

shell:
	$(DOCKER) --entrypoint /bin/sh $(TERRAFORM_DOCKER_IMAGE)

console:
	$(DOCKER) $(TERRAFORM_DOCKER_IMAGE) console $(OPTS_GLOBALS_VARS)

init:
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		init \
		$(OPTS_GLOBALS_VARS)

setup-project-checks:
	@set -e

	echo ""
	echo "To be able to create the GCP project you need to setup a GCP account."
	echo "See https://cloud.google.com/sdk/docs/authorizing for more details."
	echo ""
	echo "Right now, the available account are:"
	echo ""
	echo "-------------------------------------------------------------------------------------------------------------"
	gcloud auth list --format="value(account)"
	echo "-------------------------------------------------------------------------------------------------------------"
	gcloud auth list --filter=status:ACTIVE --format="value(account)"
	echo "-------------------------------------------------------------------------------------------------------------"
	echo ""
	echo "If you never setup 'gcloud', that could be easilly done with:"
	echo "	\$$ gcloud init --console-only"
	echo "	\$$ gcloud auth login --no-launch-browser"
	echo ""
	echo ""
	echo "Everything looks good :)"

revoke-gcloud-auth:
	@set -e -x

	gcloud auth revoke


setup-project: setup-project-checks
	@set -e -x

	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)

	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		init \
		$(OPTS_GLOBALS_VARS)

	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		plan \
		$(OPTS_GLOBALS_VARS)

	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		apply \
		$(OPTS_GLOBALS_VARS)

plan:
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		plan \
		$(OPTS_GLOBALS_VARS)

apply:
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		apply \
		$(OPTS_GLOBALS_VARS)

force-apply:
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		apply -auto-approve \
		$(OPTS_GLOBALS_VARS)

refresh:
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		refresh \
		$(OPTS_GLOBALS_VARS)

destroy:
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		destroy \
		$(OPTS_GLOBALS_VARS)


import-module:
	test -z "$(IMPORT_MODULE)" && { echo "ERROR: must pass IMPORT_MODULE variable" ; exit 1; } || true
	test -z "$(IMPORT_ID)" && { echo "ERROR: must pass IMPORT_ID variable" ; exit 1; } || true
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		import \
		$(OPTS_GLOBALS_VARS) \
		$(IMPORT_MODULE) $(IMPORT_ID)

import-resource:
	test -z "$(IMPORT_RESOURCE)" && { echo "ERROR: must pass IMPORT_RESOURCE variable" ; exit 1; } || true
	test -z "$(IMPORT_ID)" && { echo "ERROR: must pass IMPORT_ID variable" ; exit 1; } || true
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		import \
		$(OPTS_GLOBALS_VARS) \
		$(IMPORT_RESOURCE) $(IMPORT_ID)

state-rm:
	test -z "$(RESOURCE_RM)" && { echo "ERROR: must pass RESOURCE_RM variable" ; exit 1; } || true
	export GOOGLE_OAUTH_ACCESS_TOKEN=$$(gcloud auth print-access-token)
	$(DOCKER) \
		-e GOOGLE_OAUTH_ACCESS_TOKEN \
		$(TERRAFORM_DOCKER_IMAGE) \
		state rm \
		$(RESOURCE_RM)

validate:
	$(DOCKER) \
		$(TERRAFORM_DOCKER_IMAGE) \
		validate

output:
	$(DOCKER) \
		$(TERRAFORM_DOCKER_IMAGE) \
		output \
		$(ARGS_OUTPUT)

output-json:
	$(DOCKER) \
		$(TERRAFORM_DOCKER_IMAGE) \
		output -json \
		$(ARGS_OUTPUT)
