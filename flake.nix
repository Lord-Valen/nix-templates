{
  description = "My nix flake templates, using flake-compat";

  outputs = { self }: {
    templates = {
      haskell = {
        path = ./haskell;
        description = "Haskell template, using cabal2nix";
      };

      di-node = {
        path = ./node/di-node;
        description = "NodeJS Dependency Injection template, using node2nix";
      };

      ts-node = {
        path = ./node/ts-node;
        description = "NodeJS TypeScript template, using node2nix";
      };

      js-node = {
        path = ./node/js-node;
        description = "NodeJS template, using node2nix";
      };
    };
  };
}
