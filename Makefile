db:
	docker compose up -d user_db

user_clean:
	cd user && ./mvnw clean install

user_api:
	cd user && ./mvnw spring-boot:run

user_api_docker:
	docker compose up user_api --build