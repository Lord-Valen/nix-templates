{
  inputs,
  cell,
}: let
  lib = inputs.nixpkgs.lib // builtins;
  mkTemplates = templates:
    lib.mapAttrs (name: value: {
      path = ./${name};
      description = value;
    })
    templates;
in
  mkTemplates {
    haskell = "Haskell template";
    nix = "Nix library template";
    node = "NodeJS TypeScript template";
    rack = "VCV Rack plugin template";
    rust = "Rust template";
  }
