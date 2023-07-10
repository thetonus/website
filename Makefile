.DEFAULT_GOAL := help

# Other options are yarn or normal npm
NPM := pnpm

# https://www.freecodecamp.org/news/self-documenting-makefile/
.PHONY: help
help: ## Help command
	@echo "Let's build a website!\n"
	@echo "Usage:\n\tmake <command>\n"
	@echo "The commands are:\n"
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	$(NPM) install

build: install ## Build project
	$(NPM) run build

dev: install  ## Run dev server
	$(NPM) run dev

ci/install: ## CI Install
	npm install -g $(NPM)
	@make install

ci/build: ci/install build ## CI Build
