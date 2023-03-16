{
  description = "VCV Rack plugin template.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs.std.follows = "std";
    };
  };

  outputs = {
    self,
    std,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      # Limited by the current means of acquiring the Rack SDK
      # Care to do better? DO IT!
      systems = ["x86_64-linux"];

      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes; [
        (installables "packages")
        (devshells "devshells")
        (nixago "configs")
      ];
    }
    {
      packages = std.harvest self ["plugin" "packages"];
      devShells = std.harvest self ["_automation" "devshells"];
    };
}
