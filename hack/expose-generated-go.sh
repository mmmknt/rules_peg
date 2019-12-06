#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

OS="$(go env GOHOSTOS)"
ARCH="$(go env GOARCH)"
ROOT=$(dirname ${BASH_SOURCE})/..

expose_package () {
	local out_path=$1
	local package=$2
	local old_links=$(eval echo \$$3)
	local generated_files=$(eval echo \$$4)

	# Compute the relative_path from this package to the bazel-bin
	local count_paths="$(echo -n "${package}" | tr '/' '\n' | wc -l)"
	local relative_path="../../"

	# Delete all old links
	for f in ${old_links}; do
		if [[ -f "${f}" ]]; then
			echo "Deleting old link: ${f}"
			rm ${f}
		fi
	done

	# Link to the generated files
	local found=0
	for f in ${generated_files}; do
		if [[ -f "${f}" ]]; then
			found=1
			local base=${f##*/}
			echo "Adding a new link: ${package}/${base}"
			ln -nsf "${relative_path}${f}" "${package}/"
		fi
	done
	if [[ "${found}" == "0" ]]; then
		echo "Error: No generated file was found inside ${out_path} for the package ${package}"
		exit 1
	fi
}

##################
# For peg go files
##################

# Build peg go files
for label in $(bazelisk query 'attr(generator_function, peg_go, //...)'); do
	bazelisk build "${label}"
done

# Link to the generated files and add them to excluding list in the root BUILD file
for package in $(bazelisk query 'attr(generator_function, peg_go, //...)' --output package); do
	# Compute the path where Bazel puts the files
	out_path="bazel-bin/${package}"

	old_links=${package}/*.peg.go
	generated_files=${out_path}/*.peg.go
	expose_package ${out_path} ${package} old_links generated_files
done