load("@io_bazel_rules_go//go:def.bzl", "go_library")

def peg_go(name, src):
    gosrc = src + ".go"
    native.genrule(
        name = name,
        srcs = [src],
        outs = [gosrc],
        cmd = "cp $(<) $(@D) && $(location @com_github_pointlander_peg//:peg) $(@D)/%s && rm $(@D)/%s" % (src, src),
        tools = ["@com_github_pointlander_peg//:peg"],
        visibility = ["//visibility:public"],
    )