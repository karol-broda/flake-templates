# flake templates

collection of nix flake templates for various development environments.

## available templates

| template | description |
|----------|-------------|
| `bun` | development shell with bun runtime |
| `uv` | development shell for python with uv |
| `zig` | development shell for zig |
| `java` | development shell for java with zulu 24 |
| `terraform` | development shell for general terraform development |
| `go` | development shell for go 1.25 |
| `rust` | development shell for rust with rust-overlay, multiple toolchains, and wasm support |
| `c` | development shell for c with clang, make, cmake, and debugging tools |

## usage

initialize a new project with a template:

```sh
nix flake init -t github:karol-broda/flake-templates#bun
```

some templates expose multiple dev shells. for example, the rust template:

```sh
nix develop .#default      # stable
nix develop .#nightly       # nightly
nix develop .#wasm          # wasm targets
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
     your-template = {
       path = ./templates/your-template;
       description = "your template description";
     };
   };
   ```

4. generate a lock file:
   ```sh
   cd templates/your-template && nix flake lock
   ```

## formatting

this repository uses [alejandra](https://github.com/kamadorueda/alejandra) for nix formatting.

```sh
nix fmt
```

## development

this repository uses direnv. allow it with:

```sh
direnv allow
```
