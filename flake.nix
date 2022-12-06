{
  description = "My nix flake templates, using flake-compat";

  inputs.devshell = {
    url = "github:numtide/devshell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    devshell,
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      templates = {
        haskell = {
          path = builtins.path {
            path = ./haskell;
            name = "haskellTemplate";
          };
          description = "Haskell template, using cabal2nix";
        };

        node = {
          path = builtins.path {
            path = ./node;
            name = "tsNodeTemplate";
          };
          description = "NodeJS TypeScript template, using dream2nix";
        };

        rust = {
          path = builtins.path {
            path = ./rust;
            name = "rustTemplate";
          };
          description = "Rust template, using dream2nix";
        };
      };

      devShells.default = let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [devshell.overlay];
        };
      in
        pkgs.devshell.mkShell {
          imports = [
            (pkgs.devshell.extraModulesDir + "/git/hooks.nix")
            (pkgs.devshell.importTOML (builtins.path {
              path = ./devshell.toml;
              name = "devshell";
            }))
          ];

          git.hooks = {
            enable = true;
            pre-commit.text = builtins.readFile (builtins.path {
              path = ./pre-commit.sh;
              name = "pre-commit";
            });
          };
        };
    });
}
