CLUSTER?=freecluster01
APP?=guestbook

getAll:
	kubctl get nodes
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
	kubectl apply -f deployment-redismaster.yaml
	kubectl apply -f deployment-redisslave.yaml
	kubectl apply -f deployment-guestbook.yaml

serviceYaml:
	kubectl apply -f service-redismaster.yaml
	kubectl apply -f service-redisslave.yaml
	kubectl apply -f service-guestbook.yaml

scale:
	kubectl scale --replicas=10 deployment ${APP}


