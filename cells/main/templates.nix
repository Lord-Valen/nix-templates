{
  haskell = {
    path = builtins.path {
      path = ./haskell;
      name = "haskellTemplate";
    };
    description = "Haskell template, using cabal2nix";
  };

  node = {
    path = builtins.path {
      path = ./node;
      name = "tsNodeTemplate";
    };
    description = "NodeJS TypeScript template, using dream2nix";
  };

  rack = {
    path = builtins.path {
      path = ./rack;
      name = "rackTemplate";
    };
    description = "VCV Rack plugin template";
  };

  rust = {
    path = builtins.path {
      path = ./rust;
      name = "rustTemplate";
    };
    description = "Rust template, using dream2nix";
  };
}
