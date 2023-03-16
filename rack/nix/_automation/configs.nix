{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std std-data-collection;
  lib = nixpkgs.lib // builtins;
in
  with std-data-collection.data.configs; {
    editorconfig = lib.recursiveUpdate editorconfig std.lib.cfg.editorconfig {
      data = {
        "*.{c,cpp,h,hpp}" = {
          indent_size = 4;
          max_line_length = "120";
        };
      };
    };

    treefmt = std.lib.cfg.treefmt {
      packages = [
        nixpkgs.alejandra
        nixpkgs.nodePackages.prettier
        nixpkgs.clang-tools
      ];
      data.formatter = {
        nix = {
          command = "alejandra";
          includes = ["*.nix"];
        };
        prettier = {
          command = "prettier";
          includes = ["*.md" "*.json"];
        };
        cc = {
          command = "clang-format";
          includes = ["*.c" "*.cpp" "*.h" "*.hpp"];
        };
      };
    };
  }
