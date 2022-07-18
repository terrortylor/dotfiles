#!/usr/bin/env bats

setup() {
    load '../../bats/test_helper/bats-support/load'
    load '../../bats/test_helper/bats-assert/load'
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$DIR/../../src:$PATH"
}

teardown() {
  unlink alink &> /dev/null  || true
  rm -rf adirectory || true
}

@test "info - prints" {
  source scripts/common.sh
  run info "An info message"
  assert_success
  assert_output -e "^\s[[]\s.*INFO.*\s[]]\sAn info message$"
}

@test "success - prints" {
  source scripts/common.sh
  run success "A success message"
  assert_success
  assert_output -e "^\s[[]\s.*OK.*\s[]]\sA success message$"
}

@test "skip - prints" {
  source scripts/common.sh
  run skip "A skip message"
  assert_success
  assert_output -e "^\s[[]\s.*SKIP.*\s[]]\sA skip message$"
}

@test "error - prints" {
  source scripts/common.sh
  run error "A fail message"
  assert_success
  assert_output -e "^\s[[]\s.*FAIL.*\s[]]\sA fail message$"
}

@test "clone - dont't clone repository if destination exists" {
  source scripts/common.sh
  tmpDir="$(mktemp -d)"
  gitRepo="git@github.com:terrortylor/dotfiles.git"
  run clone $gitRepo $tmpDir
  assert_success
  assert_output -p "Skipping clone, path found: $tmpDir"
}

@test "clone - if destination exists" {
  source scripts/common.sh
  tmpDir="$(mktemp -d)"
  gitRepo="git@github.com:terrortylor/dotfiles.git"
  rm -rf ${tmpDir}
  function git() {
    assert_equal clone ${1}
    assert_equal ${gitRepo} ${2}
    assert_equal ${tmpDir} ${3}
  }
  export -f git

  run clone $gitRepo $tmpDir
  assert_success
  assert_output -p "OK"
}

@test "clone - if destination exists, expect error" {
  source scripts/common.sh
  tmpDir="$(mktemp -d)"
  gitRepo="git@github.com:terrortylor/dotfiles.git"
  rm -rf ${tmpDir}
  function git() {
    assert_equal clone ${1}
    assert_equal ${gitRepo} ${2}
    assert_equal ${tmpDir} ${3}
    return 1
  }
  export -f git

  run clone $gitRepo $tmpDir
  assert_success
  assert_output -p "FAIL"
}

@test "link_file - target file doesn't exists" {
  source scripts/common.sh
  target="DEOSNOTEXIST"
  run link_file $target ""
  assert_failure
  assert_output -p "Target does not exist: $target"
}

@test "link_file - skip, link exists as expected" {
  source scripts/common.sh
  target="$(mktemp)"
  file="alink"
  ln -s $target $file
  run link_file $target $file
  assert_success
  assert_output -p "Link exists"
}

@test "link_file - link exists to wrong target" {
  source scripts/common.sh
  target="$(mktemp)"
  wrongtarget="$(mktemp)"
  file="alink"
  ln -s $wrongtarget $file
  run link_file $target $file
  assert_failure
  assert_output -p "Link exists to wrong target, wanted: $target - $file"
}

@test "link_file - link already exists as file or directory" {
  source scripts/common.sh
  target="$(mktemp)"
  file="$(mktemp)"
  run link_file $target $file
  assert_failure
  assert_output -p "Link already exists as file or directory: $file"
}

@test "link_file - success" {
  source scripts/common.sh
  target="$(mktemp)"
  file=alink
  run link_file $target $file
  assert_success
  assert_output -p "OK"
}

@test "create_dir - success, dir exists" {
  source scripts/common.sh
  target="$(mktemp -d)"
  run create_dir $target
  assert_success
  assert_output -p "OK"
  assert_output -p "Creating directory: $target"
}

@test "create_dir - success dir exists" {
  source scripts/common.sh
  run create_dir adirectory
  assert_success
  assert_output -p "OK"
  assert_output -p "Creating directory: $target"
}

@test "create_dir - failure" {
  source scripts/common.sh
  target="$(mktemp)"
  run create_dir $target
  assert_failure
  assert_output -p "FAIL"
  assert_output -p "Creating directory: $target"
}
