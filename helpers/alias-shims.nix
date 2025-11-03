{ lib, pkgs }:

{ name
, package
, exe ? null           # optional explicit executable name, otherwise meta.mainProgram or lib.getExe
, extraArgs ? [ ]      # optional extra default args before "$@"
, env ? { }            # optional env vars to export before exec
}:

assert builtins.isString name && name != "";
assert lib.isDerivation package;
assert (exe == null) || builtins.isString exe;

let
  envPairs =
    lib.filterAttrs (_: v: v != null) env;

  envLines =
    lib.concatStringsSep "\n"
      (lib.mapAttrsToList (k: v: "export ${k}=${lib.escapeShellArg (toString v)}") envPairs);

  exePath =
    if exe != null then
      "${package}/bin/${exe}"
    else if package ? meta && package.meta ? mainProgram && package.meta.mainProgram != null then
      "${package}/bin/${package.meta.mainProgram}"
    else
      lib.getExe package;

  argStr =
    lib.concatMapStringsSep " " (a: lib.escapeShellArg a) extraArgs;

in
pkgs.writeShellScriptBin name ''
  #!/usr/bin/env bash
  set -euo pipefail

  ${envLines}

  exec "${exePath}" ${argStr} "$@"
''

