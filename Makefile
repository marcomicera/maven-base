all: clean checks run

.PHONY: clean
.SILENT: clean
clean:
	mvn clean

.PHONY: checks
.SILENT: checks
checks: linters gitleaks

.PHONY: linters
.SILENT: linters
linters:
	docker run \
		--rm \
		--name linters \
		--env RUN_LOCAL=true \
		--volume $(shell pwd -P):/tmp/lint \
		github/super-linter

.PHONY: gitleaks
.SILENT: gitleaks
gitleaks:
	docker run \
		--rm \
		--name gitleaks \
		--env RUN_LOCAL=true \
		--volume $(shell pwd -P):/tmp \
		zricethezav/gitleaks:latest \
		--source="/tmp" \
		--verbose \
		--redact \
		detect

.PHONY: build compile
.SILENT: build compile
build compile:
	mvn compile

.PHONY: run exec
.SILENT: run exec
run exec:
	mvn exec:java
