{
  inputs,
  cell,
}: {
  rack-sdk = let
    inherit (inputs) nixpkgs;
    sdkVer = "2.2.1";
  in
    if nixpkgs.system == "x86_64-linux"
    then
      nixpkgs.fetchzip {
        name = "Rack-SDK-${sdkVer}-lin-x64.zip";
        url = "https://vcvrack.com/downloads/Rack-SDK-${sdkVer}-lin-x64.zip";
        hash = "sha256-XECsFDrbxJas4wrc4iWdEf6xtXZ65TOjimqdwnZ9BOA=";
      }
    else if nixpkgs.system == "x86_64-darwin"
    then
      nixpkgs.fetchzip {
        name = "Rack-SDK-${sdkVer}-mac-x64.zip";
        url = "https://vcvrack.com/downloads/Rack-SDK-${sdkVer}-mac-x64.zip";
        hash = "sha256-SQkQW08qDhBf6xUptiaQAj77oIX9wMKQqDOUzpSaKQE=";
      }
    else
      nixpkgs.fetchzip {
        name = "Rack-SDK-${sdkVer}-mac-arm64.zip";
        url = "https://vcvrack.com/downloads/Rack-SDK-${sdkVer}-mac-arm64.zip";
        hash = "sha256-22v4+BsyoqRmIVswERF9LYxNft62+3+Hk47k98xJ/O8=";
      };
}
