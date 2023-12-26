{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (std.lib) dev cfg;
  inherit (cell) configs;
  lib = builtins // nixpkgs.lib;
in
  lib.mapAttrs (_: dev.mkShell) {
    default = {
      name = "nix-templates";

      nixago = with configs; [
        (dev.mkNixago cfg.lefthook lefthook)
        (dev.mkNixago cfg.treefmt treefmt)
        (dev.mkNixago cfg.conform conform)
        (dev.mkNixago cfg.editorconfig editorconfig)
      ];
    };
  }
