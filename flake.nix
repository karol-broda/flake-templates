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
      };

      defaultTemplate = self.templates.bun;
    };
}

