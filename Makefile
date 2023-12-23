.DEFAULT_GOAL := help

# Other options are yarn or normal npm
COMMAND := bun

# https://www.freecodecamp.org/news/self-documenting-makefile/
.PHONY: help
help: ## Help command
	@echo "Let's build a website!\n"
	@echo "Usage:\n\tmake <command>\n"
	@echo "The commands are:\n"
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: export ASTRO_TELEMETRY_DISABLED=1
install: ## Install dependencies
	$(COMMAND) install

build: export ASTRO_TELEMETRY_DISABLED=1
build: install ## Build project
	$(COMMAND) run build

dev: export ASTRO_TELEMETRY_DISABLED=1
dev: install  ## Run dev server
	$(COMMAND) run dev

