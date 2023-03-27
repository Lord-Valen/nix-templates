{
  inputs,
  cell,
}: let
  inherit (inputs) self;
in {
  haskell = {
    path = self + "/haskell";
    description = "Haskell template, using cabal2nix";
  };

  node = {
    path = self + "/node";
    description = "NodeJS TypeScript template, using dream2nix";
  };

  rack = {
    path = self + "/rack";
    description = "VCV Rack plugin template";
  };

  rust = {
    path = self + "/rust";
    description = "Rust template, using dream2nix";
  };
}
