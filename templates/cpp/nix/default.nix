{pkgs}: let
  buildInputs = import ./build-inputs.nix {inherit pkgs;};
  devTools = import ./dev-tools.nix {inherit pkgs;};
  shells = import ./shells.nix {inherit pkgs buildInputs devTools;};
in {inherit buildInputs devTools shells;}
