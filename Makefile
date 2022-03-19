.PHONY: help build serve

.DEFAULT_GOAL := help

# https://www.freecodecamp.org/news/self-documenting-makefile/
help: ## Help command
	@echo "Let's build a website!\n"
	@echo "Usage:\n\tmake <command>\n"
	@echo "The commands are:\n"
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## Build frontend and compile assests
	# Add google analytics at build time.
	sed -i s/G_ANALYTICS_TAG_PLACEHOLDER/${G_ANALYTICS_TAG}/g config/_default/config.toml
	# Build static site
	hugo --minify --gc

serve:  ## Start development server
	hugo server 
