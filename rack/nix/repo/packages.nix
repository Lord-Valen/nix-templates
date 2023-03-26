{ inputs, cell, }:
let inherit (inputs) nixpkgs std self;
in {
  default = cell.packages.my-plugin;
  my-plugin = nixpkgs.stdenv.mkDerivation {
    pname = "MyPlugin";
    version = "2.0.0";

    src = std.incl self [
      "CMakeLists.txt"
      "RackSDK.cmake"
      "plugin.json"
      "README.md"
      "src"
      "res"
      "vendor"
    ];

    cmakeFlags = [ "-DRACK_SDK_DIR=${inputs.cells.repo.toolchain.rack-sdk}" ];

    buildInputs = [ nixpkgs.cmake ];
  };
}
