{
  description = "TS-Node template, using node2nix";

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
        packageName = throw "You done forgot to put in the dang package name!";
      in {
        packages = {
          default = self.packages.${system}.${packageName};

          ${packageName} = pkgs.stdenv.mkDerivation {
            name = packageName;
            src = self;
            buildInputs = with pkgs; [ nodejs ];

            buildPhase = let
              nodeDeps = (pkgs.callPackage ./default.nix { }).nodeDependencies;
            in ''
              rm -rf node_modules
              ln -s ${nodeDeps}/lib/node_modules node_modules
              export PATH="${nodeDeps}/bin:$PATH"

              npm run build;
            '';

            installPhase = ''
              mkdir -p $out
              cp -r dist $out
            '';
          };
        };

        devShells.default = let
          nodeEnv = pkgs.callPackage ./node-env.nix { };
          nodePkgs = pkgs.callPackage ./node-packages.nix {
            globalBuildInputs = with pkgs; [ node2nix ];
            inherit nodeEnv;
          };
        in nodePkgs.shell.overrideAttrs (oldAttrs: {
          shellHook = oldAttrs.shellHook + ''
            export PS1='dev:\w > \[$(tput sgr0)\]'

            # Certain tools (including jest) will not work properly without this.
            rm -rf node_modules
            ln -s $NODE_PATH node_modules

            abort() {
              rm -rf node_modules
            }

            trap abort EXIT
          '';
        });
      });
}
