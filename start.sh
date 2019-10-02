#!/bin/bash

# run controller
function startcontroller {
	docker run -d \
	-p 8053:53/udp \
	-p 5098:5098 \
	-p 9080:9080 \
	-p 9443:9443 \
	-p 8443:8443 \
	-p 5054:5054 \
	-p 161:161 \
	--privileged \
	--name=avicontroller \
	-e HTTP_PORT=9080 \
	-e HTTPS_PORT=9443 \
	-e CONTAINER_NAME=avicontroller \
	-e MANAGEMENT_IP=127.0.0.1 \
	-e NUM_CPU=4 \
	-e NUM_MEMG=8 \
	-e DISK_GB=50 \
	-v ${HOME}/avi:/hostroot/ \
	-v ${HOME}/avi/controller/data:/vol/ \
	-v /var/run/docker.sock:/var/run/docker.sock \
	avinetworks/controller
}

# run se
function startse {
	docker run -d -P \
	--privileged \
	--name=avise \
	-e NTHREADS=1 \
	-e SEMEMMB=1024 \
	-e DISKSZ=10240 \
	-e LOG_DISKSZ=5120 \
	-v ${HOME}/avi/se/data:/vol/ \
	-v ${HOME}/avi:/hostroot/ \
	-v /etc/localtime:/etc/localtime \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-e DOCKERNETWORKMODE=HOST \
	-e CONTROLLERIP=172.17.0.2 \
	-e CONTAINER_NAME=avise \
	-e CNTRL_SSH_PORT=5098 \
	-e SYSINT_PORT=8443 \
	-e SE_INBAND_MGMT=true \
	avinetworks/se
}

startcontroller
startse
