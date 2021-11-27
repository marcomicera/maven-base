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
