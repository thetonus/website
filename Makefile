.PHONY: build serve

SRC := exampleSite
PWD := $(shell pwd)

build:
	cd $(SRC) && hugo --minify --gc --themesDir ../..

serve:
	cd $(SRC) && hugo server --themesDir ../..
