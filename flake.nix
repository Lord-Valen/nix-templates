{
  description = "My nix flake templates, using flake-compat";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs.std.follows = "std";
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

      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        (devshells "devshells")
        (data "templates")
      ];
    }
    {
      templates = std.pick self ["main" "templates"];
      devShells = std.harvest self ["_automation" "devshells"];
    };
}
