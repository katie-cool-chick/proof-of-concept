#!/bin/bash -x
set -o pipefail
name="${0##*/}"
export HELM_NAMESPACE="$name"
cleanup() {
	set +e
	helm uninstall wankery; echo $?
	helm uninstall wankery-broken-api-1; echo $?
	helm uninstall wankery-broken-api-2; echo $?
	helm uninstall wankery-deprecated-api; echo $?
}
cleanup
set -e
helm upgrade --install --create-namespace --dry-run wankery ./wankery; echo $?
cleanup
