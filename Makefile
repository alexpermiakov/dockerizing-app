.PHONY: run-prod
run-prod:
	docker compose -f docker-compose.yml --env-file .env up --build

.PHONY: run-dev
run-dev:
	docker compose -f docker-compose-dev.yml --env-file .env up --build

.PHONY: run-debug
run-debug:
	docker compose -f docker-compose-dev.yml -f docker-compose-debug.yml --env-file .env up --build

.PHONY: run-test
run-test:
	docker compose -f docker-compose-dev.yml -f docker-compose-test.yml --env-file .env up --build api-golang-dev
	docker compose -f docker-compose-dev.yml -f docker-compose-test.yml --env-file .env up --build api-node-dev
