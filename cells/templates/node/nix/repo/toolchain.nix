{
  inputs,
  cell,
}: let
  inherit (inputs) self std dream2nix;
in {
  dream2nix = dream2nix.lib.makeFlakeOutputs {
    systems = [inputs.nixpkgs.system];
    config.projectRoot = self;
    source = std.incl self [
      (self + /package.json)
      (self + /package-lock.json)
      (self + /tsconfig.json)
      (self + /src)
      (self + /nix)
    ];
    projects = {
      hello = {
        name = "hello";
        subsystem = "nodejs";
        subsystemInfo.nodejs = 18;
        translator = "package-lock";
      };
    };
  };
}
