db:
	docker compose up -d user_db

user_api:
	cd user && mvn spring-boot:run