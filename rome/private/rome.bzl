"Internal implementation details"

_attrs = {
    "data": attr.label_list(
        allow_files = True,
        doc = "Runtime dependencies of the program.",
    ),
    "command": attr.string_list(
        doc = "Command to use with Rome, see https://docs.rome.tools/cli/",
    ),
    "config": attr.label(
        doc = "Label of a configuration file for Rome, see https://docs.rome.tools/configuration/",
        allow_single_file = True,
    ),
    "_launcher_template": attr.label(
        default = Label("//rome/private:rome_launcher.tpl"),
        allow_single_file = True,
    ),
    "_windows_constraint": attr.label(
        default = "@platforms//os:windows",
    ),
}

def _impl(ctx):
    rome_toolchain = ctx.toolchains["@build_bazel_rules_rome//rome:toolchain_type"]

    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])
    if is_windows:
        launcher_extension = ".bat"
    else:
        launcher_extension = ""

    launcher_subst = {
        "{{binary}}": rome_toolchain.romeinfo.rome_binary,
        "{{command}}": " ".join(ctx.attr.command[:]),
    }
    launcher_name = ctx.attr.name + launcher_extension
    launcher = ctx.actions.declare_file(launcher_name)

    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        substitutions = launcher_subst,
        is_executable = True,
    )

    inputs = ctx.files.data[:]
    inputs.extend(rome_toolchain.romeinfo.tool_files)

    if ctx.file.config:
        inputs.append(ctx.file.config)

    runfiles = ctx.runfiles(
        files = inputs,
    ).merge_all([
        target[DefaultInfo].default_runfiles
        for target in ctx.attr.data
    ])

    return DefaultInfo(
        executable = launcher,
        runfiles = runfiles,
    )

rome = struct(
    implementation = _impl,
    attrs = dict(_attrs),
    toolchains = ["@build_bazel_rules_rome//rome:toolchain_type"],
)
