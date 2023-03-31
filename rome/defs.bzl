"""API for running the Rome cli under Bazel

Simplest usage:

```starlark
load("@build_bazel_rules_rome//rome:defs.bzl", "rome_check_test", "rome_format_test")

rome_check_test(name = "...")

rome_format_test(name = "...")
```

## Tools

Rome can be run under Bazel to edit the source files in place instead of printing a result.

### Rome Linter

[https://docs.rome.tools/linter/](https://docs.rome.tools/linter/)

Rome's linter statically analyzes your code to catch common errors and helps you write more idiomatic code.

You can use Bazel to run the [Rome linter](https://docs.rome.tools/linter/) in your project's root directory.

```bash
$ bazel run @build_bazel_rules_rome//:check
```

This will lint all source files and is equivalent to running the Rome linter with the --write option.

```bash
$ rome check --write
```

### Rome Formatter

[https://docs.rome.tools/formatter/](https://docs.rome.tools/formatter/)

Rome's formatter formats your code and helps you to catch stylistic errors.

You can use Bazel to run the [Rome formatter](https://docs.rome.tools/formatter/) in your project's root directory.

```bash
$ bazel run @build_bazel_rules_rome//:format
```

This is will format all your source files and is equivalent to running the Rome formatter with the --apply option.

```bash
$ rome format --apply
```

## Configuring Rome

https://docs.rome.tools/configuration/

The --@build_bazel_rules_rome//:rome.json setting can be used to define the configuration file used by the Rome formatter and linter.

A flag can be added to the .bazelrc file to ensure a consistent configuration file is used whenever the Rome formatter or linter is run.

.bazelrc

```bash
build --@build_bazel_rules_rome//:rome.json=//:rome.json
```

The configuration file can also be specified individually.

```bash
$ bazel run @build_bazel_rules_rome//:format --@build_bazel_rules_rome//:rome.json=//rome.json
```
"""

load("//rome/private:rome.bzl", _rome_lib = "rome")
load("@aspect_bazel_lib//lib:utils.bzl", "file_exists", "to_label")
load("@bazel_skylib//lib:types.bzl", "types")
load("@bazel_skylib//rules:write_file.bzl", "write_file")

COMMON_FILE_EXTENSIONS = ["**/*.ts", "**/*.mts", "**/*.cts", "**/*.tsx", "**/*.jsx", "**/*.mjs", "**/*.cjs", "**/*.js"]

rome = rule(
    doc = """Underlying rule for the executable macros.

Use this if you need more control over how the rule is called.
""",
    implementation = _rome_lib.implementation,
    attrs = _rome_lib.attrs,
    toolchains = _rome_lib.toolchains,
    executable = True,
)

rome_test = rule(
    doc = """Underlying testing rule for the test macros.

Use this if you need more control over how the testing rule is called.
""",
    implementation = _rome_lib.implementation,
    attrs = _rome_lib.attrs,
    toolchains = _rome_lib.toolchains,
    test = True,
)

"Rome check testing macro"
def rome_check_test(name, data = None, options = [], config = None, **kwargs):
    """Execute the Rome linter

    https://docs.rome.tools/linter/

    Rome's linter statically analyzes your code to catch common errors and helps you write more idiomatic code.

    Args:
        name: A name for the target

        srcs: List of labels of TypeScript or JavaScript source files.

        options: Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options
        
        config: Label of a rome.json configuration file for Rome, see https://docs.rome.tools/configuration/
            Instead of a label, you can pass a dictionary matching the JSON schema.

        **kwargs: passed through to underlying [`rome_test`](#rome_test), eg. `visibility`, `tags`
    """
    if data == None:
        data = native.glob(COMMON_FILE_EXTENSIONS)
    elif not types.is_list(data):
        fail("data must be a list, not a " + type(data))

    if config == None:
        if file_exists(to_label(":rome.json")):
            config = "rome.json"
    elif type(config) == type(dict()):
        write_file(
            name = "_gen_rome_config_" + name,
            out = "rome.json",
            content = [json.encode(config)]
        )

        # From here, the configuration becomes a file path, the same as if the
        # user supplied a rome.json InputArtifact
        config = "rome.json"

    rome_test(
        name = name,
        command = "ci",
        options = ["--formatter-enabled=false"] + options + ["."],
        config = config,
        data = data,
        **kwargs
    )

"Rome formatter testing macro"
def rome_format_test(name, data = None, options = [], config = None, **kwargs):
    """Execute the Rome formatter

    https://docs.rome.tools/formatter/

    Rome's formatter formats your code and helps you to catch stylistic errors.

    Args:
        name: A name for the target

        srcs: List of labels of TypeScript or JavaScript source files.

        options: Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options

        config: Label of a rome.json configuration file for Rome, see https://docs.rome.tools/configuration/
            Instead of a label, you can pass a dictionary matching the JSON schema.

        **kwargs: passed through to underlying [`rome_test`](#rome_test), eg. `visibility`, `tags`
    """
    if data == None:
        data = native.glob(COMMON_FILE_EXTENSIONS)
    elif not types.is_list(data):
        fail("data must be a list, not a " + type(data))

    if config == None:
        if file_exists(to_label(":rome.json")):
            config = "rome.json"
    elif type(config) == type(dict()):
        write_file(
            name = "_gen_rome_config_" + name,
            out = "rome.json",
            content = [json.encode(config)]
        )

        # From here, the configuration becomes a file path, the same as if the
        # user supplied a rome.json InputArtifact
        config = "rome.json"

    rome_test(
        name = name,
        command = "ci",
        options = ["--linter-enabled=false"] + options + ["."],
        config = config,
        data = data,
        **kwargs
    )
