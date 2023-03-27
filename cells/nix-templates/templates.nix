{
  inputs,
  cell,
}: let
  lib = inputs.nixpkgs.lib // builtins;
  mkTemplates = templates:
    lib.mapAttrs (name: value: {
      path = "./" + toString name;
      description = value;
    })
    templates;
in
  mkTemplates {
    haskell = "Haskell template";
    node = "NodeJS TypeScript template, using dream2nix";
    rack = "VCV Rack plugin template";
    rust = "Rust template, using dream2nix";
  }
