{
  description = "Haskell template, using cabal2nix";

  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        haskPkgs = pkgs.haskellPackages;

        packageName = throw "You done forgot to put in the dang package name!";
      in {
        packages = {
          default = self.packages.${system}.${packageName};

          ${packageName} = haskPkgs.callCabal2nix packageName self { };
        };

        devShells.default = haskPkgs.shellFor {
          packages = p: [ self.packages.${system}.${packageName} ];
          withHoogle = true;
          buildInputs = with pkgs; [
            cabal-install
            ghcid
            haskellPackages.haskell-language-server
          ];

          shellHook = "export PS1='\\e[1;34mdev > \\e[0m'";
        };
      });
}
