{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (nixpkgs) lib;
  inherit (std.lib) dev;
in
  lib.mapAttrs (_: dev.mkShell) {
    nixpkgs = {
      name = "nixpkgs";
      commands = with nixpkgs; [
        {
          name = "nom";
          package = nix-output-monitor;
        }
        {package = nixpkgs-fmt;}
        {
          name = "nixpkgs-hammer";
          package = nixpkgs-hammering;
        }
        {package = nixpkgs-lint-community;}
        {package = nixpkgs-review;}
        {package = nix-update;}
        {package = nix-init;}
        {package = prefetch-npm-deps;}
        {package = prefetch-yarn-deps;}
        {package = nix-universal-prefetch;}
      ];
      nixago = [];
    };
  }
