{
  description = "My nix flake templates, using flake-compat";

  outputs = { self }: {
    templates =
      let inherit (builtins) path; in
      {
        haskell = {
          path = path { path = ./haskell; name = "haskellTemplate"; };
          description = "Haskell template, using cabal2nix";
        };

        node = {
          path = path { path = ./node; name = "tsNodeTemplate"; };
          description = "NodeJS TypeScript template, using dream2nix";
        };

        rust = {
          path = path { path = ./rust; name = "rustTemplate"; };
          description = "Rust template, using dream2nix";
        };
      };
  };
}
