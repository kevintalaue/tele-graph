PY_VER ?= 3.12
SHELL := /bin/bash
REPOSITORY := kevintalaue/data-view
GIT_HASH := $(shell git rev-parse HEAD)

ifndef GITHUB_RUN_ID
GITHUB_RUN_ID=latest
endif

.PHONY: test
test:
	tox -p -o

.PHONY: clean_test
clean_test:
	rm -rf .tox
	tox -p -o

.PHONY: clean_env
clean_env:
	rm -Rf ./env

.PHONY: build_env
build_env:
	python$(PY_VER) -m venv env
	@echo ""
	@echo "********** Run \`source env/bin/activate\` before continuing **********"
	@echo ""

.PHONY: rebuild_env
rebuild_env: | clean_env build_env

.PHONY: requirements
requirements:
	pip install --upgrade pip
	pip install --upgrade pip-tools
	pip-compile -rU --resolver=backtracking --no-emit-index-url requirements.in

.PHONY: install_reqs
install_reqs:
	pip install --upgrade pip
	pip install -r requirements.txt
