{
  description = "collection of nix flake templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
  }: let
    supportedSystems = import systems;
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
  in {
    templates = {
      bun = {
        path = ./templates/bun;
        description = "development shell with bun runtime";
      };
      uv = {
        path = ./templates/uv;
        description = "development shell for python with uv";
      };
      zig = {
        path = ./templates/zig;
        description = "development shell for zig";
      };
      java = {
        path = ./templates/java;
        description = "development shell for java with zulu 24";
      };
      terraform = {
        path = ./templates/terraform;
        description = "development shell for general terraform development";
      };
      go = {
        path = ./templates/go;
        description = "development shell for go 1.25";
      };
      rust = {
        path = ./templates/rust;
        description = "development shell for rust with rust-overlay, multiple toolchains, and wasm support";
      };
      c = {
        path = ./templates/c;
        description = "development shell for c with clang, make, cmake, and debugging tools";
      };
      cpp = {
        path = ./templates/cpp;
        description = "development shell for c++ with clang, cmake, ninja, vulkan sdk, and debugging tools";
      };
    };

    templates.default = self.templates.bun;

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = [
          pkgs.alejandra
          pkgs.nix
        ];

        shellHook = ''
          if [ -n "$PS1" ]; then
            echo "flake-templates dev shell"
            echo "  alejandra: $(alejandra --version)"
            echo ""
            echo "run 'nix fmt' to format all nix files"
          fi
        '';
      };
    });
  };
}
