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
        {package = nixpkgs-fmt;}
        {package = nixpkgs-hammering;}
        {package = nixpkgs-lint-community;}
        {package = nixpkgs-review;}
        {package = nix-update;}
        {package = nix-init;}
        {package = prefetch-npm-deps;}
        {package = prefetch-yarn-deps;}
        {package = nix-prefetch-universal;}
      ];
      nixago = [];
    };
  }
