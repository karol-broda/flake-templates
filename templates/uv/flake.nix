{
  description = "uv-managed python devshell flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
  };

  outputs = { self, nixpkgs }:
    let
      mkShellFor = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lib = nixpkgs.lib;
        in
        pkgs.mkShell {
          packages = with pkgs; [
            uv
          ];
          shellHook = ''
            unset UV_PYTHON
            unset UV_NO_MANAGED_PYTHON
            if [ -n "$PS1" ]; then
              echo "uv: $(${lib.getExe pkgs.uv} --version | head -n1)"
              # show which python uv will use
              PY="$(uv python find 2>/dev/null || true)"
              if [ -n "$PY" ]; then
                echo "python (uv): $("$PY" --version) at $PY"
              else
                echo "python (uv): none installed; run 'uv python install' or pin with 'uv python pin <major.minor>'"
              fi
            fi
          '';
        };
    in
    {
      devShells.x86_64-linux.default = mkShellFor "x86_64-linux";
      devShells.aarch64-linux.default = mkShellFor "aarch64-linux";
      devShells.x86_64-darwin.default = mkShellFor "x86_64-darwin";
      devShells.aarch64-darwin.default = mkShellFor "aarch64-darwin";
    };
}
