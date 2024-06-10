db:
	docker compose up -d user_db

user_clean:
	cd user && ./mvnw clean install

user_api:
	cd user && ./mvnw spring-boot:run

user_api_docker:
	docker compose up user_api --build

cluster:
	k3d cluster create my-cluster --servers 1 --agents 2 --port "3000:3000@loadbalancer" --port "8080:8080@loadbalancer"
	docker build -t my-db:0.0.1 -f ./database/user/Dockerfile ./database/user
	docker build -t my-user:0.0.1 -f ./user/Dockerfile ./user
	docker build -t my-grafana-lgtm:0.0.1 -f ./grafana/Dockerfile ./grafana
	k3d image import my-db:0.0.1 my-user:0.0.1 my-grafana-lgtm:0.0.1 --cluster my-cluster

cluster_delete:
	k3d cluster delete my-cluster