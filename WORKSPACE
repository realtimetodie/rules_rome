# Declare the local Bazel workspace.
workspace(name = "build_bazel_rules_rome")

load(":internal_deps.bzl", "rules_rome_internal_deps")

# Fetch deps needed only locally for development
rules_rome_internal_deps()

load("//rome:dependencies.bzl", "rules_rome_dependencies")

# Fetch our "runtime" dependencies which users need as well
rules_rome_dependencies()

load("//rome:repositories.bzl", "rome_register_toolchains")

rome_register_toolchains(
    name = "default_rome",
    # Demonstrates how users can choose ANY Rome version, not just the ones we mirrored
    integrity_hashes = {
        "darwin-arm64": "sha384-9vPxwnf/VZwOoElmbhjzn/lSKkn+5IX+5fHf817iEJjp6ncyiGurUC76/xFKse0c",
        "darwin-x64": "sha384-8/0E6xbBWdVVk3vDkPTcs4VFgCbnMZ/vJGamAeylzT4PyRwXaMP4xe4fr3Suoah8",
        "linux-arm64": "sha384-c4YyPE4ae1gG6FN5LeOnM5bCZETcZwq/wZA97I6Ho5EXKWhraKNE04SoUtYgQEsr",
        "linux-x64": "sha384-m7QeYmacu5GXNMLpYeICJCccDDxCJ0mWiNOUXfvQgncUmg/IZ/8ANLAU+zEpyIc1",
        "win32-arm64": "sha384-Ge8veb8mZFZdfNJyXLMQgrT9v6QwLqtchMhyXe7YBk9wJh7N/vHaDLZwhg1xGa5Q",
        "win32-x64": "sha384-2HyldKiql0ojktmvJRvpSFj/Lv6BlYyuEKHRMqBD1sJmCiBaT0ZNRQB8oGs3lQSe",
    },
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
