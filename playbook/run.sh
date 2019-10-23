#!/bin/bash

docker run --rm -it \
	-v ${PWD}/credentials:/root/.aws/credentials \
	-v ${PWD}/create-aws-virtual.yml:/ansible/playbooks/create-aws-virtual.yml \
	-v ${PWD}/vars.yml:/ansible/playbooks/vars.yml \
apnex/ansible -vvv create-aws-virtual.yml
