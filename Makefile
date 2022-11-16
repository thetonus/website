.PHONY: help 

.DEFAULT_GOAL := help

# Use PNPM if possible
PNPM_EXISTS=$(shell which pnpm > /dev/null && echo 1 || echo 0 )
ifeq ($(PNPM_EXISTS), 1)
	COMMAND=pnpm
else
	COMMAND=npm
endif

# https://www.freecodecamp.org/news/self-documenting-makefile/
help: ## Help command
	@echo "Let's build a website!\n"
	@echo "Usage:\n\tmake <command>\n"
	@echo "The commands are:\n"
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	$(COMMAND) install

build: install ## Build project
	$(COMMAND) run build

dev: install  ## Run dev server
	$(COMMAND) run dev
