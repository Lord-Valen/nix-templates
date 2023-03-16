{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  lib = inputs.nixpkgs.lib // builtins;
in
  lib.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "vcv-prefabs";
      packages = [];
      commands = [];
      nixago = with cell.configs;
        [
          editorconfig
          treefmt
        ]
        ++ (with inputs.std-data-collection.data.configs; [
          conform
          lefthook
        ]);
    };
  }
