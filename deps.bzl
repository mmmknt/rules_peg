load("@bazel_gazelle//:deps.bzl", "go_repository")

def peg_rules_dependencies():
    go_repository(
        name = "com_github_pointlander_peg",
        importpath = "github.com/pointlander/peg",
        commit = "169894c6af14e914b8ee20035b2fe22f222d77af",
    )

    go_repository(
        name = "com_github_pointlander_jetset",
        importpath = "github.com/pointlander/jetset",
        commit = "eee7eff80bd4f18ff56a0eef8d5b005c8d592e7a",
    )

    go_repository(
        name = "com_github_pointlander_compress",
        importpath = "github.com/pointlander/compress",
        commit = "ff44bd196cc34cff192fd5c586f74b9ca7fc9a11",
    )
