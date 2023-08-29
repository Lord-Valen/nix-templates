{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  lib = nixpkgs.lib // builtins;
in
  lib.mapAttrs (_: inputs.std.lib.dev.mkShell) {
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
