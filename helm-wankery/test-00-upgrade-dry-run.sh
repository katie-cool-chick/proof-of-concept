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
runtest() {
	local rc=0
	(set -x; helm upgrade --install --create-namespace --dry-run "$1" "./$1" > /dev/null) || rc="$?"
	echo "Expected $2 got $rc"
	[ "$rc" == "$2" ]
}
cleanup
set -e
runtest wankery 0
runtest wankery-broken-api-1 1
runtest wankery-broken-api-2 0
set +ex
cleanup
