{
  description = "c development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
  }: let
    supportedSystems = import systems;
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    mkPkgs = system: nixpkgs.legacyPackages.${system};
  in {
    devShells = forAllSystems (system: let
      pkgs = mkPkgs system;
    in {
      default = pkgs.mkShell {
        packages = with pkgs;
          [
            clang
            gnumake
            cmake
            pkg-config
            bear
            cppcheck
            clang-tools
          ]
          ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
            gdb
            valgrind
          ]
          ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
            lldb
          ];

        buildInputs = with pkgs;
          [
            openssl
            zlib
          ]
          ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
            libiconv
          ];

        env = {
          CC = "clang";
          OPENSSL_NO_VENDOR = "1";
          OPENSSL_DIR = "${pkgs.openssl.dev}";
          OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
          OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
        };

        shellHook = ''
          if [ -n "$PS1" ]; then
            echo "c dev shell"
            echo "  clang: $(clang --version | head -n1)"
            echo "  make:  $(make --version | head -n1)"
          fi
        '';
      };
    });

    formatter = forAllSystems (system: (mkPkgs system).alejandra);
  };
}
