"""API for running Rome under Bazel

Simplest usage:

```starlark
load("@build_bazel_rules_rome//rome:defs.bzl", "rome_check_test")

rome_check_test(name = "...")
```

## Tools

### Linter

The Rome linter can be run to edit the source files in place instead of printing a result.

https://docs.rome.tools/linter/

```bash
$ bazel run @build_bazel_rules_rome//rome:rome_check
```

This is equivalent to running the Rome linter with the --write option.

### Formatter

The Rome formatter can be run to edit the source files in place instead of printing a result.

https://docs.rome.tools/formatter/

```bash
$ bazel run @build_bazel_rules_rome//rome:rome_format
```

This is equivalent to running the Rome formatter with the --apply option.

## Configuration

The --@build_bazel_rules_rome//:rome.json setting can be used to define the configuration file used by the Rome formatter and linter.

A flag can be added to the .bazelrc file to ensure a consistent configuration file is used whenever the Rome formatter or linter is run

```bash
build --@build_bazel_rules_rome//:rome.json=//:rome.json
```

The configuration file can also be specified individually

```bash
$ bazel run @build_bazel_rules_rome//rome:rome_format --@build_bazel_rules_rome//:rome.json=//rome.json
```
"""

load("//rome/private:rome.bzl", _rome_bin = "rome")
load("@bazel_skylib//lib:types.bzl", "types")

rome = rule(
    doc = """Underlying rule for the executable macros.

Use this if you need more control over how the rule is called.
""",
    implementation = _rome_bin.implementation,
    attrs = _rome_bin.attrs,
    toolchains = _rome_bin.toolchains,
    executable = True,
)

rome_test = rule(
    doc = """Underlying rule for the test macros.

Use this if you need more control over how the rule is called.
""",
    implementation = _rome_bin.implementation,
    attrs = _rome_bin.attrs,
    toolchains = _rome_bin.toolchains,
    test = True,
)

def rome_check_test(name, data = None, options = [], config = None, **kwargs):
    """Execute the Rome linter https://docs.rome.tools/linter/

    Args:
        name: A name for the target
        data: Runtime dependencies of the program
        options: Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options
        config: Label of a configuration file for Rome, see https://docs.rome.tools/configuration/
        **kwargs: Additional named parameters like tags or visibility
    """
    if data == None:
        data = native.glob(["**/*.js", "**/*.mjs", "**/*.ts", "**/*.tsx"])
    elif not types.is_list(data):
        fail("data must be a list, not a " + type(data))

    rome_test(
        name = name,
        data = data,
        command = ["ci", "--formatter-enabled=false"] + options + ["."],
        config = config,
        **kwargs
    )

def rome_format_test(name, data = None, options = [], config = None, **kwargs):
    """Execute the Rome formatter https://docs.rome.tools/formatter/

    Args:
        name: A name for the target
        data: Runtime dependencies of the program
        options: Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options
        config: Label of a configuration file for Rome, see https://docs.rome.tools/configuration/
        **kwargs: Additional named parameters like tags or visibility
    """
    if data == None:
        data = native.glob(["**/*.js", "**/*.mjs", "**/*.ts", "**/*.tsx"])
    elif not types.is_list(data):
        fail("data must be a list, not a " + type(data))

    rome_test(
        name = name,
        data = data,
        command = ["ci", "--linter-enabled=false"] + options + ["."],
        config = config,
        **kwargs
    )
