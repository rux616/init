#!/usr/bin/env bash
# shellcheck disable=SC2034  # these are meant to be used elsewhere

declare -A default

default[XDG_CACHE_HOME]="${HOME}/.cache"
default[XDG_CONFIG_HOME]="${HOME}/.config"
default[XDG_DATA_HOME]="${HOME}/.data"
