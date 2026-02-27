{pkgs}: {
  core = with pkgs;
    [
      clang
      cmake
      ninja
      bear
      clang-tools
      cppcheck
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      gdb
      valgrind
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      lldb
    ];

  vulkan = with pkgs;
    [
      vulkan-tools
      shaderc
      spirv-tools
      spirv-cross
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      renderdoc
    ];
}
