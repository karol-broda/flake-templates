{
  description = "collection of nix flake templates";

  outputs = { self }:
    {
      templates = {
        bun = {
          path = ./templates/bun;
          description = "development shell with bun runtime";
        };
      };

      defaultTemplate = self.templates.bun;
    };
}

