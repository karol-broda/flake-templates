# flake templates

collection of nix flake templates for various development environments.

## usage

initialize a new project with a template:

```sh
nix flake init -t github:karol-broda/flake-templates#bun
```

## adding new templates

1. create a new directory under `templates/`:

   ```sh
   mkdir templates/your-template
   ```

2. add a `flake.nix` in that directory

3. register it in the root `flake.nix`:
   ```nix
   templates = {
     bun = {
       path = ./templates/bun;
       description = "development shell with bun runtime";
     };
     your-template = {
       path = ./templates/your-template;
       description = "your template description";
     };
   };
   ```

## development

this repository uses direnv. allow it with:

```sh
direnv allow
```
