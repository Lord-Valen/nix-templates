{
  description = "NodeJS TypeScript template, using dream2nix";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "nixpkgs";

    dream2nix = {
      url = "github:nix-community/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { dream2nix, nixpkgs, ... }:
    let
      systems =
        [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems
        (system: f system (nixpkgs.legacyPackages.${system}));
      projectRoot = builtins.path {
        path = ./.;
        name = "projectRoot";
      };

      d2n-flake = dream2nix.lib.makeFlakeOutputs {
        inherit systems;
        config.projectRoot = projectRoot;
        source = projectRoot;
        settings = [{ subsystemInfo.nodejs = 18; }];
      };
    in dream2nix.lib.dlib.mergeFlakes [
      d2n-flake
      {
        devShells = forAllSystems (system: pkgs: {
          default = d2n-flake.devShells.${system}.default.overrideAttrs (old: {
            buildInputs = old.buildInputs ++ [
              # Formatters
              pkgs.treefmt
              pkgs.alejandra
              pkgs.nodePackages.prettier

              # Lint
              pkgs.editorconfig-checker
            ];
          });
        });
      }
    ];
}
