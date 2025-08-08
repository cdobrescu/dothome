#!/usr/bin/env bash
. utils

echo -n "Downloading NVIM binary         "
run_with_spinner bash -c "sleep 2"

echo -n "Testing the error               "
run_with_spinner bash -c "sleep 2; echo error >/dev/stderr; exit 1"

echo -n "Downloading NVIM binary         "
run_with_spinner bash -c "sleep 2"



