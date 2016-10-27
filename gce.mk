include $(shell git rev-parse --show-toplevel)/terraform.mk

.PHONY: default
default: hello

CONFIG_FILES := \
	config/bastion-env \
	config/gce-workers-$(ENV_SHORT).json \
	config/vault-consul-env \
	config/worker-env-com \
	config/worker-env-org

.PHONY: .config
.config: $(CONFIG_FILES) $(ENV_NAME).tfvars

$(CONFIG_FILES):
	mkdir -p config
	cp -v $$TRAVIS_KEYCHAIN_DIR/travis-keychain/gce/*.json config/
	trvs generate-config -p TRAVIS_WORKER -f env gce-workers $(ENV_SHORT) \
		| sed 's/^/export /' >config/worker-env-org
	trvs generate-config --pro -p TRAVIS_WORKER -f env gce-workers $(ENV_SHORT) \
		| sed 's/^/export /' >config/worker-env-com
	trvs generate-config --pro -p GCE_BASTION -f env gce-bastion $(ENV_SHORT) \
		| sed 's/^/export /' >config/bastion-env
	trvs generate-config -p GCE_VAULT_CONSUL -f env gce-vault-consul $(ENV_SHORT) \
		>config/vault-consul-env
