"""Starlark helper to fetch rules_swc dependencies.

Should be replaced by bzlmod for users of Bazel 6.0 and above.
"""

load("//rome/private:maybe.bzl", http_archive = "maybe_http_archive")

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
def rules_rome_dependencies():
    http_archive(
        name = "bazel_skylib",
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
        urls = ["https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz"],
    )

    http_archive(
        name = "aspect_bazel_lib",
        sha256 = "3534a27621725fbbf1d3e53daa0c1dda055a2732d9031b8c579f917d7347b6c4",
        strip_prefix = "bazel-lib-1.16.1",
        url = "https://github.com/aspect-build/bazel-lib/archive/refs/tags/v1.16.1.tar.gz",
    )
