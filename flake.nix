{
  description = "collection of nix flake templates";

  outputs = { self }:
    {
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
      };

      defaultTemplate = self.templates.bun;
    };
}

