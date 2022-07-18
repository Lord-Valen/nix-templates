{
  description = "My nix flake templates, using flake-compat";

  outputs = { self }: {
    templates = {
      haskell = {
        path = ./haskell;
        description = "Haskell template, using cabal2nix";
      };

      ts-node = {
        path = ./ts-node;
        description = "NodeJS TypeScript template, using node2nix";
      };

      js-node = {
        path = ./js-node;
        description = "NodeJS template, using node2nix";
      };
    };
  };
}
