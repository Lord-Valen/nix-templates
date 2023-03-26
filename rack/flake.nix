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
      systems = ["x86_64-linux" "x86_64-darwin" "aarch64-darwin"];

      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes; [
        (installables "packages")
        (devshells "devshells")
        (nixago "configs")
        (functions "toolchain")
      ];
    }
    {
      packages = std.harvest self ["repo" "packages"];
      devShells = std.harvest self ["repo" "devshells"];
    };
}
