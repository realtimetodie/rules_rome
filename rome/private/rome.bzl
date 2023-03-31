"Internal implementation details"

load("@aspect_bazel_lib//lib:platform_utils.bzl", "platform_utils")
load("@aspect_bazel_lib//lib:windows_utils.bzl", "create_windows_native_launcher_script")

_attrs = {
    "data": attr.label_list(
        allow_files = True,
        doc = "Runtime dependencies of the program.",
    ),
    "command": attr.string(
        doc = """The command to use with Rome

        https://docs.rome.tools/cli/""",
    ),
    "options": attr.string_list(
        doc = """Additional options to use with Rome

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
}

def _impl(ctx):
    rome_toolchain = ctx.toolchains["@build_bazel_rules_rome//rome:toolchain_type"]

    inputs = ctx.files.data[:]
    inputs.extend(rome_toolchain.romeinfo.tool_files)

    options = ctx.attr.options

    if ctx.file.config:
        inputs.append(ctx.file.config)
        options = list(["--config-path=" + ctx.file.config.dirname]) + ctx.attr.options

    bash_launcher = ctx.actions.declare_file("%s.sh" % ctx.label.name)

    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = bash_launcher,
        substitutions = {
            "{{rome}}": rome_toolchain.romeinfo.rome_binary,
            "{{command}}": ctx.attr.command,
            "{{options}}": " ".join(options[:]),
        },
        is_executable = True,
    )

    is_windows = platform_utils.host_platform_is_windows()
    launcher = create_windows_native_launcher_script(ctx, bash_launcher) if is_windows else bash_launcher

    runfiles = ctx.runfiles(
        files = [bash_launcher] + inputs,
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
    toolchains = [
        "@bazel_tools//tools/sh:toolchain_type",
        "@build_bazel_rules_rome//rome:toolchain_type",
    ],
)
