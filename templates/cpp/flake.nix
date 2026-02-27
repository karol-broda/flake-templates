{
  description = "c++ vulkan development flake";

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

    mkPkgs = system: nixpkgs.legacyPackages.${system};

    mkModules = system:
      import ./nix {
        pkgs = mkPkgs system;
      };
  in {
    devShells = forAllSystems (system: let
      modules = mkModules system;
    in {
      inherit (modules.shells) default vulkan;
    });

    formatter = forAllSystems (system: (mkPkgs system).alejandra);
  };
}
