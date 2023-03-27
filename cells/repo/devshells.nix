{
  inputs,
  cell,
}: let
  lib = inputs.nixpkgs.lib // builtins;
in
  lib.mapAttrs (_: inputs.std.lib.dev.mkShell) {
    default = {...}: {
      name = "nix-templates";
      nixago = with inputs.std-data-collection.data.configs; [
        treefmt
        lefthook
        editorconfig
        (conform {data = {inherit (inputs) cells;};})
      ];
    };
  }
