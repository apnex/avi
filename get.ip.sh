#!/bin/bash

echo '## AVI Controller IP ##'
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' avicontroller
echo '## AVI ServiceEngine IP ##'
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' avise
