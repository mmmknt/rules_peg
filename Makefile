.PHONY: gazelle
gazelle:
	bazelisk run //:gazelle

.PHONY: expose-generated-go
expose-generated-go:
	./hack/expose-generated-go.sh

.PHONY: dep
dep:
	GO111MODULE=on go mod tidy
	GO111MODULE=on go mod vendor
	bazelisk run //:gazelle -- update-repos -from_file=tests/example/go.mod -to_macro=repositories.bzl%go_repositories -prune=true