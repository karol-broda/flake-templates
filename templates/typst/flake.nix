{
  description = "typst document development flake";

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
        packages = with pkgs; [
          typst
          tinymist
          typstyle
          watchexec
          just
        ];

        shellHook = ''
          if [ -n "$PS1" ]; then
            echo "typst dev shell"
            echo "  typst:    $(typst --version)"
            echo "  tinymist: $(tinymist --version 2>&1 | head -n1)"
            echo "  typstyle: $(typstyle --version)"
          fi
        '';
      };
    });

    formatter = forAllSystems (system: (mkPkgs system).alejandra);
  };
}
