help:
	@echo "Show in Makefile"

all: allure go docker-compose jdk k8s sonar-scanner-cli openssl

allure:
	bash ./sh/download-allure.sh

go:
	bash ./sh/download-go.sh

docker-compose:
	bash ./sh/download-docker-compose.sh

jdk:
	bash ./sh/download-jdk.sh

k8s:
	bash ./sh/download-k8s-tools.sh

sonar-scanner-cli:
	bash ./sh/download-sonar-scanner-cli.sh

openssl:
	bash ./sh/download-openssl.sh
