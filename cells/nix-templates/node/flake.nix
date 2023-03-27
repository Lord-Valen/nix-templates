{
  description = "NodeJS TypeScript template, using dream2nix";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    dream2nix = {
      url = "github:nix-community/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    dream2nix,
    ...
  }: let
    projectRoot = builtins.path {
      path = ./.;
      name = "projectRoot";
    };

    d2n-flake = dream2nix.lib.makeFlakeOutputs {
      systems = flake-utils.lib.defaultSystems;
      config.projectRoot = projectRoot;
      source = projectRoot;
      projects = {
        hello = {
          name = "hello";
          subsystem = "nodejs";
          subsystemInfo.nodejs = 18;
          translator = "package-lock";
        };
      };
    };
  in
    dream2nix.lib.dlib.mergeFlakes [
      d2n-flake
      (flake-utils.lib.eachDefaultSystem (
        system: let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          devShells = {
            default = d2n-flake.devShells.${system}.default.overrideAttrs (old: {
              buildInputs =
                old.buildInputs
                ++ [
                  # Formatters
                  pkgs.treefmt
                  pkgs.alejandra
                  pkgs.nodePackages.prettier

                  # Lint
                  pkgs.editorconfig-checker
                ];
            });
          };
        }
      ))
    ];
}
