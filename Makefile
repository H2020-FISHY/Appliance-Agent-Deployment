ENVIRONMENT ?= vagrant
DEPLOY_DIR = $(PWD)
ENV_DIR = $(DEPLOY_DIR)/environments/$(ENVIRONMENT)
ANSIBLE_DIR = $(DEPLOY_DIR)/ansible
ANSIBLE_ENV = ANSIBLE_ROLES_PATH=$(ANSIBLE_DIR)/roles ANSIBLE_HASH_BEHAVIOUR=merge
FORCE_RESTART ?= False

include $(ENV_DIR)/$(ENVIRONMENT).mk


ANSIBLE_ARGS = -i $(ENV_DIR)/inventory \
							 --private-key=$(SSH_PRIVATE_KEY) \
							 -e ansible_dir=$(ANSIBLE_DIR) \
							 -e '{ force_restart: $(FORCE_RESTART) }' \
							 -e environment_dir=$(ENV_DIR) \
							 -u $(SSH_USER) $(EXTRA_ARGS)
reprovision:
	@ANSIBLE_HOST_KEY_CHECKING=False $(ANSIBLE_ENV) ansible-playbook $(ANSIBLE_ARGS) $(ANSIBLE_DIR)/books/provision-reset-deploy.yml
	@ANSIBLE_HOST_KEY_CHECKING=False $(ANSIBLE_ENV) ansible-playbook $(ANSIBLE_ARGS) $(ANSIBLE_DIR)/books/provision.yml

provision:
	@ANSIBLE_HOST_KEY_CHECKING=False $(ANSIBLE_ENV) ansible-playbook $(ANSIBLE_ARGS) $(ANSIBLE_DIR)/books/provision.yml

PROVISION_TARGETS=$(notdir $(basename $(wildcard $(ANSIBLE_DIR)/books/provision-*.yml)))
$(PROVISION_TARGETS):
	@ANSIBLE_HOST_KEY_CHECKING=False $(ANSIBLE_ENV) ansible-playbook $(ANSIBLE_ARGS) $(ANSIBLE_DIR)/books/$@.yml
