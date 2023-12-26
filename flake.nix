{
  description = "My nix flake templates, using flake-compat";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/v0.1.0.tar.gz";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        devshell.follows = "devshell";
        nixago.follows = "nixago";
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

      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        (nixago "configs")
        (devshells "devshells")
        (functions "templates")
      ];
    }
    {
      templates = std.pick self ["templates" "templates"];
      devShells = std.harvest self ["devshells" "devshells"];
    };
}
