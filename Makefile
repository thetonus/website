.PHONY: build serve

PWD:=$(shell pwd)

build:
	hugo --minify --gc

serve:
	hugo server 
