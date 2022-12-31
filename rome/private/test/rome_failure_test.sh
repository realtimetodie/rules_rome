#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${BUILD_WORKSPACE_DIRECTORY:-}" ]]; then
  echo "This script should be run under Bazel"
  exit 1
fi

cd "${BUILD_WORKSPACE_DIRECTORY}"

# Executes a bazel build command and handles the return value, exiting
# upon seeing an error.
#
# Takes two arguments:
# ${1}: The expected return code.
# ${2}: The target within "//rome/private/test" to be tested.
function check_build_result() {
  local ret=0
  echo -n "Testing ${2}... "
  (bazel test //rome/private/test:"${2}" &> /dev/null) || ret="$?" && true
  if [[ "${ret}" -ne "${1}" ]]; then
    echo "FAIL: Unexpected return code [saw: ${ret}, want: ${1}] building target //rome/private/test:${2}"
    echo "  Run \"bazel test //rome/private/test:${2}\" to see the output"
    exit 1rome/private/test
  else
    echo "OK"
  fi
}

function test_all_and_apply() {
  local -r TEST_OK=0
  local -r TEST_FAILED=3

  temp_dir="$(mktemp -d -t ci-XXXXXXXXXX)"
  new_workspace="${temp_dir}/build_bazel_rules_rome_test"
  
  mkdir -p "${new_workspace}/rome/private/test" && \
  cp -r rome/private/test/* "${new_workspace}/rome/private/test/" && \
  cat << EOF > "${new_workspace}/WORKSPACE.bazel"
workspace(name = "build_bazel_rules_rome_test")
local_repository(
    name = "build_bazel_rules_rome",
    path = "${BUILD_WORKSPACE_DIRECTORY}",
)
load("@build_bazel_rules_rome//rome:dependencies.bzl", "rules_rome_dependencies")

rules_rome_dependencies()

load("@build_bazel_rules_rome//rome:repositories.bzl", "rome_register_toolchains")

rome_register_toolchains(name = "rome")
EOF

  pushd "${new_workspace}"

  check_build_result $TEST_FAILED test_block_stmt_error

  check_build_result $TEST_OK test_formatted
  check_build_result $TEST_FAILED test_unformatted

  popd

  rm -rf "${temp_dir}"
}

test_all_and_apply