#!/bin/bash
poetry run python scripts/setup
PGPT_PROFILES=local make run
