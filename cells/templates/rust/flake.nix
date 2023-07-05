{
  description = "Rust template, using dream2nix";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "nixpkgs";
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

    d2nFlake = dream2nix.lib.makeFlakeOutputs {
      systems = flake-utils.lib.defaultSystems;
      config.projectRoot = projectRoot;
      source = projectRoot;
    };
  in
    dream2nix.lib.dlib.mergeFlakes [
      d2nFlake
      (flake-utils.lib.eachDefaultSystem (system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells = {
          default = d2nFlake.devShells.${system}.default.addConfig {
            packages = [
              pkgs.treefmt
              pkgs.alejandra
              pkgs.rustfmt
              pkgs.editorconfig-checker
            ];
          };
        };
      }))
    ];
}
