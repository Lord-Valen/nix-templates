{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
  };

  outputs = {
    self,
    std,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = self + "/cells";
      cellBlocks = with std.blockTypes; [
        (functions "lib")
        (devshells "devshells")
        (nixago "configs")
      ];
    }
    {
      devShells = std.harvest self ["repo" "devshells"];
      lib = std.pick self ["library" "lib"];
      # Use this if your library is system-dependent
      # lib = std.harvest self ["library" "lib"];
    };
}
