{
  description = "NodeJS TypeScript template, using dream2nix";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs";

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs = {
        std.follows = "std";
        nixpkgs.follows = "nixpkgs";
      };
    };

    dream2nix = {
      url = "github:nix-community/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    std,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = self + "/nix";
      cellBlocks = with std.blockTypes; [
        (installables "packages")
        (devshells "devshells")
        (functions "toolchain")
        (nixago "configs")
        (functions "lib")
      ];
    }
    {
      packages = std.harvest self ["app" "packages"];
      devShells = std.harvest self ["repo" "devshells"];
    };
}
