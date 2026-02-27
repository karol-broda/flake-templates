{pkgs}: {
  base = with pkgs;
    [
      openssl
      zlib
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      libiconv
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.CoreServices
    ];

  vulkan = with pkgs;
    [
      vulkan-headers
      vulkan-loader
      vulkan-validation-layers
      glfw
      glm
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      moltenvk
    ];

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  baseEnv = {
    CC = "clang";
    CXX = "clang++";
    OPENSSL_NO_VENDOR = "1";
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
  };

  vulkanEnv =
    {
      VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
    }
    // pkgs.lib.optionalAttrs pkgs.stdenv.isDarwin {
      VK_ICD_FILENAMES = "${pkgs.moltenvk}/share/vulkan/icd.d/MoltenVK_icd.json";
    };
}
