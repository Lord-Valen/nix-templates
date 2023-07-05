{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.toolchain) dream2nix;
  packages = dream2nix.packages.${inputs.nixpkgs.system};
in rec {
  default = hello;
  hello = packages.hello;
}
