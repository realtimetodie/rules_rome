<!-- Generated with Stardoc: http://skydoc.bazel.build -->

API for running Rome under Bazel

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


<a id="rome"></a>

## rome

<pre>
rome(<a href="#rome-name">name</a>, <a href="#rome-command">command</a>, <a href="#rome-config">config</a>, <a href="#rome-data">data</a>)
</pre>

Underlying rule for the executable macros.

Use this if you need more control over how the rule is called.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rome-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="rome-command"></a>command |  Command to use with Rome, see https://docs.rome.tools/cli/   | List of strings | optional | <code>[]</code> |
| <a id="rome-config"></a>config |  Label of a configuration file for Rome, see https://docs.rome.tools/configuration/   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="rome-data"></a>data |  Runtime dependencies of the program.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |


<a id="rome_test"></a>

## rome_test

<pre>
rome_test(<a href="#rome_test-name">name</a>, <a href="#rome_test-command">command</a>, <a href="#rome_test-config">config</a>, <a href="#rome_test-data">data</a>)
</pre>

Underlying rule for the test macros.

Use this if you need more control over how the rule is called.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rome_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="rome_test-command"></a>command |  Command to use with Rome, see https://docs.rome.tools/cli/   | List of strings | optional | <code>[]</code> |
| <a id="rome_test-config"></a>config |  Label of a configuration file for Rome, see https://docs.rome.tools/configuration/   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="rome_test-data"></a>data |  Runtime dependencies of the program.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |


<a id="rome_check_test"></a>

## rome_check_test

<pre>
rome_check_test(<a href="#rome_check_test-name">name</a>, <a href="#rome_check_test-data">data</a>, <a href="#rome_check_test-options">options</a>, <a href="#rome_check_test-config">config</a>, <a href="#rome_check_test-kwargs">kwargs</a>)
</pre>

Execute the Rome linter https://docs.rome.tools/linter/

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rome_check_test-name"></a>name |  A name for the target   |  none |
| <a id="rome_check_test-data"></a>data |  Runtime dependencies of the program   |  <code>None</code> |
| <a id="rome_check_test-options"></a>options |  Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options   |  <code>[]</code> |
| <a id="rome_check_test-config"></a>config |  Label of a configuration file for Rome, see https://docs.rome.tools/configuration/   |  <code>None</code> |
| <a id="rome_check_test-kwargs"></a>kwargs |  Additional named parameters like tags or visibility   |  none |


<a id="rome_format_test"></a>

## rome_format_test

<pre>
rome_format_test(<a href="#rome_format_test-name">name</a>, <a href="#rome_format_test-data">data</a>, <a href="#rome_format_test-options">options</a>, <a href="#rome_format_test-config">config</a>, <a href="#rome_format_test-kwargs">kwargs</a>)
</pre>

Execute the Rome formatter https://docs.rome.tools/formatter/

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rome_format_test-name"></a>name |  A name for the target   |  none |
| <a id="rome_format_test-data"></a>data |  Runtime dependencies of the program   |  <code>None</code> |
| <a id="rome_format_test-options"></a>options |  Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options   |  <code>[]</code> |
| <a id="rome_format_test-config"></a>config |  Label of a configuration file for Rome, see https://docs.rome.tools/configuration/   |  <code>None</code> |
| <a id="rome_format_test-kwargs"></a>kwargs |  Additional named parameters like tags or visibility   |  none |


