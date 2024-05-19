SHELL := /bin/bash
PATH := bin:$(PATH)
ENV ?= pre
KUBESPRAY_VERSION=v2.24.0
KUBE_VERSION ?= v1.28.6
PWD=$(shell pwd)

BIN=docker run --rm -it \
	-e ANSIBLE_COLLECTIONS_PATH="${HOME}"/.ansible/collections \
	--mount type=bind,source="$(PWD)/$(ENV)/kubespray/",dst=/inventory/ \
    --mount type=bind,source="${HOME}"/.ssh/,dst=/root/.ssh/,readonly \
    --mount type=bind,source="${HOME}"/.ansible/,dst=/root/.ansible/ \
	--mount type=bind,source="$(PWD)/$(ENV)/ansible/",dst=/ansible/ \
	--mount type=bind,source="$(PWD)/$(ENV)/kubespray/host_vars/",dst=/kubespray/host_vars/ \
    quay.io/kubespray/kubespray:$(KUBESPRAY_VERSION)

shell:
	$(BIN) bash

pre_install:
	$(BIN) ansible-playbook -i /inventory/inventory.ini /ansible/pre_install.yaml

install:
	$(BIN) ansible-playbook -i /inventory/inventory.ini cluster.yml --skip-tags=multus -b

uninstall:
	$(BIN) ansible-playbook -i /inventory/inventory.ini reset.yml -b

upgrade_cluster:
	$(BIN) ansible-playbook -i /inventory/inventory.ini upgrade-cluster.yml --skip-tags=multus -e kube_version=$(KUBE_VERSION) -e upgrade_cluster_setup=true -b -l $(NODE)

docker_to_containerd:
	$(BIN) ansible-playbook -i /inventory/inventory.ini cluster.yml -l $(NODE) -e kube_version=$(KUBE_VERSION) -b
