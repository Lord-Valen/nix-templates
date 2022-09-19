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

        di-node = {
          path = path { path = ./node/di-node; name = "diNodeTemplate"; };
          description = "NodeJS Dependency Injection template, using node2nix";
        };

        ts-node = {
          path = path { path = ./node/ts-node; name = "tsNodeTemplate"; };
          description = "NodeJS TypeScript template, using node2nix";
        };

        js-node = {
          path = path { path = ./node/js-node; name = "jsNodeTemplate"; };
          description = "NodeJS template, using node2nix";
        };

        rust = {
          path = path { path = ./rust; name = "rustTemplate"; };
          description = "Rust template, using dream2nix";
        };
      };
  };
}
