{
  pkgs,
  buildInputs,
  devTools,
}: let
  mkCppShell = {
    name,
    extraPackages ? [],
    extraBuildInputs ? [],
    extraEnv ? {},
    shellHookExtra ? "",
  }:
    pkgs.mkShell (
      {
        packages =
          devTools.core
          ++ buildInputs.nativeBuildInputs
          ++ extraPackages;

        buildInputs = buildInputs.base ++ extraBuildInputs;

        shellHook = ''
          if [ -n "$PS1" ]; then
            echo "${name} dev shell"
            echo "  clang:  $(clang --version | head -n1)"
            echo "  cmake:  $(cmake --version | head -n1)"
            echo "  ninja:  $(ninja --version)"
          fi
          ${shellHookExtra}
        '';
      }
      // buildInputs.baseEnv
      // extraEnv
    );
in {
  default = mkCppShell {
    name = "c++";
  };

  vulkan = mkCppShell {
    name = "c++ vulkan";
    extraPackages = devTools.vulkan;
    extraBuildInputs = buildInputs.vulkan;
    extraEnv = buildInputs.vulkanEnv;
    shellHookExtra = ''
      if [ -n "$PS1" ]; then
        echo "  glslc:  $(glslc --version 2>&1 | head -n1)"
      fi
    '';
  };

  inherit mkCppShell;
}
