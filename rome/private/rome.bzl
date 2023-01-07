"Internal implementation details"

_attrs = {
    "data": attr.label_list(
        allow_files = True,
        doc = "Runtime dependencies of the program.",
    ),
    "cmd": attr.string_list(
        doc = """Additional arguments to use with Rome

        https://docs.rome.tools/cli/""",
    ),
    "config": attr.label(
        doc = """Label of a rome.json configuration file
        
        https://docs.rome.tools/configuration/""",
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
        "{{rome_bin}}": rome_toolchain.romeinfo.rome_binary,
        "{{cmd}}": " ".join(ctx.attr.cmd[:]),
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
    attrs = _attrs,
    implementation = _impl,
    toolchains = ["@build_bazel_rules_rome//rome:toolchain_type"],
)
