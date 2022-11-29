#!/bin/bash
set -o pipefail
name="${0##*/}"
export HELM_NAMESPACE="$name"
cleanup() {
	helm uninstall wankery; echo $?
	helm uninstall wankery-broken-api-1; echo $?
	helm uninstall wankery-broken-api-2; echo $?
	helm uninstall wankery-deprecated-api; echo $?
}
cleanup
set -ex
helm upgrade --install --create-namespace --dry-run wankery ./wankery; echo $?
! helm upgrade --install --create-namespace --dry-run wankery-broken-api-1 ./wankery-broken-api-1; echo $?
set +ex
cleanup
