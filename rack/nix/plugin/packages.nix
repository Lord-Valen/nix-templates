{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
in {
  default = cell.packages.my-plugin;
  my-plugin = nixpkgs.stdenv.mkDerivation {
    pname = "MyPlugin";
    version = "2.0.0";

    src = std.incl self [
      "CMakeLists.txt"
      "RackSDK.cmake"
      "plugin.json"
      "src"
      "res"
      "README.md"
    ];

    cmakeFlags = let
      rack-sdk = nixpkgs.fetchzip {
        name = "Rack-SDK-2.2.3-lin-x64.zip";
        url = "https://vcvrack.com/downloads/Rack-SDK-2.2.3-lin-x64.zip";
        sha256 = "4p1q34R0DXPmjqF2lJX0NIPr5TR16MEJHWWM3/vAhPY=";
      };
    in [
      "-DRACK_SDK_DIR=${rack-sdk}"
    ];

    buildInputs = [
      nixpkgs.cmake
    ];
  };
}
