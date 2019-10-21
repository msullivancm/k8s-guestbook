CLUSTER?=freecluster01
APP?=guestbook

getAll:
	kubectl get nodes
	@echo "\n"
	kubectl get deployments
	@echo "\n"
	kubectl get pods -o wide
	@echo "\n"
	kubectl get services -o wide
	@echo "\n" 
	kubectl get hpa

getPublicIP:
	ibmcloud cs workers --cluster=${CLUSTER}

getClusterInfo:
	ibmcloud cs cluster-get ${CLUSTER} --showResources

deployYaml:
	kubectl apply -f deploymentRedisMaster.yaml
	kubectl apply -f deploymentRedisSlave.yaml
	kubectl apply -f deploymentFrontEnd.yaml

serviceYaml:
	kubectl apply -f serviceRedisMaster.yaml
	kubectl apply -f serviceRedisSlave.yaml
	kubectl apply -f serviceFrontEnd.yaml

scale:
	kubectl scale -Replicas=10 deployment ${APP}


