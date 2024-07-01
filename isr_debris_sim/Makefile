# Makefile

# Python Variables
PYTHON = python3.12
VENV = .venv
DIST = dist
VENVTOUCHFILE = $(VENV)/.touchfile
BIN = $(VENV)/bin


.PHONY: help	
help:		## Show Help
	@echo "------------------------------------------------------"
	@echo "Use this file to Install, Test, Check Project"
	@echo "------------------------------------------------------"
	@grep -v 'sed -n' $(MAKEFILE_LIST) | sed -n 's/^\(.*\):.*##\(.*\)/\1: \2/p' | sort | awk 'BEGIN {FS = ": "; OFS = ": "}; {printf "%-20s %s\n", $$1, $$2}'

.PHONY: install-env
install-env: $(VENV)		## Install Virtual Environment

$(VENV):
	$(PYTHON) -m venv $(VENV)
	$(BIN)/pip install pip-tools
	touch $(VENV)

.PHONY: install-dev
install-dev:		## Install Package and Dev Dependencies
	$(BIN)/pip install -r requirements.txt

.PHONY: install
install: install-env install-dev	## Install environment and dev dependencies

.PHONY: check
check:		## Run mypy type checker
	$(BIN)/mypy ./src

.PHONY: clean
clean:		## Clean repo of build artifacts
	git clean -dfX .

.PHONY: format
format:		## Format Python Files
	$(BIN)/ruff check --select I --fix-only --exit-zero .
	$(BIN)/ruff format .

.PHONY: test
test:		## Run Unit Tests
	$(BIN)/pytest -m unit
	$(BIN)/pytest --dead-fixtures --dup-fixtures


