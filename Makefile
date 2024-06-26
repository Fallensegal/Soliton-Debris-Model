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

.PHONY: install
install: $(VENV)		## Install Virtual Environment

$(VENV):
	$(PYTHON) -m venv $(VENV)
	$(BIN)/pip install pip-tools
	touch $(VENV)


