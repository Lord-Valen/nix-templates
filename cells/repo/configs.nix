{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs cells;
in {
  editorconfig = {
    hook.mode = "copy";
    data = {
      root = true;

      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        charset = "utf-8";
        indent_style = "space";
        indent_size = 2;
      };

      "*.{diff,patch}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        indent_size = "unset";
      };

      "*.md" = {
        max_line_length = "off";
        trim_trailing_whitespace = false;
      };

      "{LICENSES/**,LICENSE}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        charset = "unset";
        indent_style = "unset";
        indent_size = "unset";
      };
    };
  };

  conform = {
    data = {
      inherit cells;
      commit = {
        header = {length = 89;};
        conventional = {
          types = [
            "build"
            "chore"
            "ci"
            "docs"
            "feat"
            "fix"
            "perf"
            "refactor"
            "style"
            "test"
          ];
          scopes = [];
        };
      };
    };
  };

  treefmt = {
    packages = with nixpkgs; [
      alejandra
      nodePackages.prettier
      shfmt
    ];
    data = {
      excludes = ["cells/templates"];
      formatter = {
        nix = {
          command = "alejandra";
          includes = ["*.nix"];
        };
        prettier = {
          command = "prettier";
          options = ["--write"];
          includes = [
            "*.md"
            "*.json"
            "*.yaml"
          ];
        };
      };
    };
  };

  lefthook = {
    data = {
      commit-msg = {
        commands = {
          conform = {
            # allow WIP, fixup!/squash! commits locally
            run = ''
              [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
              conform enforce --commit-msg-file {1}'';
            skip = ["merge" "rebase"];
          };
        };
      };
      pre-commit = {
        commands = {
          treefmt = {
            run = "treefmt --fail-on-change {staged_files}";
            skip = ["merge" "rebase"];
          };
        };
      };
    };
  };
}
