# Declare the local Bazel workspace.
workspace(name = "build_bazel_rules_rome")

load(":internal_deps.bzl", "rules_rome_internal_deps")

# Fetch deps needed only locally for development
rules_rome_internal_deps()

load("//rome:dependencies.bzl", "rules_rome_dependencies")

# Fetch our "runtime" dependencies which users need as well
rules_rome_dependencies()

load("//rome:repositories.bzl", "LATEST_VERSION", "rome_register_toolchains")

rome_register_toolchains(
    name = "default_rome",
    rome_version = LATEST_VERSION,
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

aspect_bazel_lib_dependencies(override_local_config_platform = True)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

############################################
# Gazelle, for generating bzl_library targets
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.19.3")

gazelle_dependencies()
