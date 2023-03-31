<!-- Generated with Stardoc: http://skydoc.bazel.build -->

API for running the Rome cli under Bazel

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


<a id="rome"></a>

## rome

<pre>
rome(<a href="#rome-name">name</a>, <a href="#rome-command">command</a>, <a href="#rome-config">config</a>, <a href="#rome-data">data</a>, <a href="#rome-options">options</a>)
</pre>

Underlying rule for the executable macros.

Use this if you need more control over how the rule is called.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rome-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="rome-command"></a>command |  The command to use with Rome<br><br>        https://docs.rome.tools/cli/   | String | optional | <code>""</code> |
| <a id="rome-config"></a>config |  Label of a rome.json configuration file<br><br>        https://docs.rome.tools/configuration/   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="rome-data"></a>data |  Runtime dependencies of the program.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="rome-options"></a>options |  Additional options to use with Rome<br><br>        https://docs.rome.tools/cli/   | List of strings | optional | <code>[]</code> |


<a id="rome_test"></a>

## rome_test

<pre>
rome_test(<a href="#rome_test-name">name</a>, <a href="#rome_test-command">command</a>, <a href="#rome_test-config">config</a>, <a href="#rome_test-data">data</a>, <a href="#rome_test-options">options</a>)
</pre>

Underlying testing rule for the test macros.

Use this if you need more control over how the testing rule is called.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rome_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="rome_test-command"></a>command |  The command to use with Rome<br><br>        https://docs.rome.tools/cli/   | String | optional | <code>""</code> |
| <a id="rome_test-config"></a>config |  Label of a rome.json configuration file<br><br>        https://docs.rome.tools/configuration/   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="rome_test-data"></a>data |  Runtime dependencies of the program.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="rome_test-options"></a>options |  Additional options to use with Rome<br><br>        https://docs.rome.tools/cli/   | List of strings | optional | <code>[]</code> |


<a id="rome_check_test"></a>

## rome_check_test

<pre>
rome_check_test(<a href="#rome_check_test-name">name</a>, <a href="#rome_check_test-data">data</a>, <a href="#rome_check_test-options">options</a>, <a href="#rome_check_test-config">config</a>, <a href="#rome_check_test-kwargs">kwargs</a>)
</pre>

Execute the Rome linter

https://docs.rome.tools/linter/

Rome's linter statically analyzes your code to catch common errors and helps you write more idiomatic code.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rome_check_test-name"></a>name |  A name for the target   |  none |
| <a id="rome_check_test-data"></a>data |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="rome_check_test-options"></a>options |  Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options   |  <code>[]</code> |
| <a id="rome_check_test-config"></a>config |  Label of a rome.json configuration file for Rome, see https://docs.rome.tools/configuration/ Instead of a label, you can pass a dictionary matching the JSON schema.   |  <code>None</code> |
| <a id="rome_check_test-kwargs"></a>kwargs |  passed through to underlying [<code>rome_test</code>](#rome_test), eg. <code>visibility</code>, <code>tags</code>   |  none |


<a id="rome_format_test"></a>

## rome_format_test

<pre>
rome_format_test(<a href="#rome_format_test-name">name</a>, <a href="#rome_format_test-data">data</a>, <a href="#rome_format_test-options">options</a>, <a href="#rome_format_test-config">config</a>, <a href="#rome_format_test-kwargs">kwargs</a>)
</pre>

Execute the Rome formatter

https://docs.rome.tools/formatter/

Rome's formatter formats your code and helps you to catch stylistic errors.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rome_format_test-name"></a>name |  A name for the target   |  none |
| <a id="rome_format_test-data"></a>data |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="rome_format_test-options"></a>options |  Additional options to pass to Rome, see https://docs.rome.tools/cli/#common-options   |  <code>[]</code> |
| <a id="rome_format_test-config"></a>config |  Label of a rome.json configuration file for Rome, see https://docs.rome.tools/configuration/ Instead of a label, you can pass a dictionary matching the JSON schema.   |  <code>None</code> |
| <a id="rome_format_test-kwargs"></a>kwargs |  passed through to underlying [<code>rome_test</code>](#rome_test), eg. <code>visibility</code>, <code>tags</code>   |  none |


