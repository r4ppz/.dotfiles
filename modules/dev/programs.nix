{ config, ... }:

{
  programs = {
    git = {
      enable = true;

      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };

      lfs.enable = true;

      settings = {
        core = {
          editor = "nvim";
          pager = "delta";
          autocrlf = "input";
          whitespace = "-indent-with-non-tab,trailing-space,cr-at-eol";
        };

        user = {
          name = "r4ppz";
          email = "johnreyrabosa.f@gmail.com";
        };

        init.defaultBranch = "main";
        column.ui = "auto";
        tag.sort = "version:refname";

        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };

        pull.rebase = true;
        rebase.updateRefs = true;
        commit.verbose = true;
        branch.sort = "-committerdate";

        fetch = {
          prune = true;
          all = true;
        };

        diff = {
          tool = "nvimdiff";
          context = 3;
        };

        "difftool \"nvimdiff\"".cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";

        merge = {
          tool = "nvimdiff";
          conflictStyle = "zdiff3";
        };

        "mergetool \"nvimdiff\"".cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\" -c 'wincmd J'";

        interactive.diffFilter = "delta --color-only";

        delta = {
          navigate = true;
          line-numbers = true;
          side-by-side = false;
          hyperlinks = true;
          blame-code-style = "syntax";

          # Used by lazygit: `delta --features=lazygit-theme`
          "lazygit-theme" = {
            dark = true;
            file-style = "omit";
            width = -2;
            syntax-theme = "gruvbox-dark";
            plus-style = "syntax #002800";
          };
        };

        help.autocorrect = "prompt";

        rerere = {
          enabled = true;
          autoupdate = true;
        };
      };
    };

    pgcli = {
      enable = true;
      settings = {
        main = {
          multi_line = true;
          table_format = "fancy_grid";
          syntax_style = "vim";
          multiline_continuation_char = "' '";
          prompt = "' \\n \\u:  \\d[\\p]\\n '";
        };

        colors = {
          "Token.Menu.Completions.Completion.Current" = "'bg:#ebdbb2 #282828'";
          "Token.Menu.Completions.Completion" = "'bg:#3c3836 #ebdbb2'";
          "Token.Menu.Completions.Meta.Current" = "'bg:#83a598 #282828'";
          "Token.Menu.Completions.Meta" = "'bg:#458588 #282828'";
          "Token.Menu.Completions.MultiColumnMeta" = "'bg:#458588 #282828'";
          "Token.Menu.Completions.ProgressButton" = "'bg:#fabd2f'";
          "Token.Menu.Completions.ProgressBar" = "'bg:#83a598'";
          "Token.SelectedText" = "'#ebdbb2 bg:#b16286'";
          "Token.SearchMatch" = "'#ebdbb2 bg:#b16286'";
          "Token.SearchMatch.Current" = "'#ebdbb2 bg:#b8bb26'";
          "Token.Toolbar" = "'bg:#282828 #aaaaaa'";
          "Token.Toolbar.Off" = "'bg:#282828 #888888'";
          "Token.Toolbar.On" = "'bg:#282828 #ebdbb2'";
          "Token.Toolbar.Transaction.Valid" = "'bg:#282828 #b8bb26 bold'";
          "Token.Toolbar.Transaction.Failed" = "'bg:#282828 #fb4934 bold'";
          "Token.Output.Header" = "'#fabd2f bold'";
          "literal.string" = "'#b8bb26'";
          "literal.number" = "'#d3869b'";
          "keyword" = "'bold #fabd2f'";
        };
      };
    };

    atuin = {
      enable = true;
      settings = {
        inline_height = 15;
        invert = true;
        show_help = false;
        enter_accept = true;
        theme.name = "gruvbox";
        ui.columns = [ "command" ];
      };

      themes.gruvbox = {
        theme = {
          name = "gruvbox";
          parent = "default";
        };

        colors = {
          Important = "#83a598";
          Annotation = "#928374";
          Guidance = "#b8bb26";
          AlertInfo = "#83a598";
          AlertWarn = "#fabd2f";
          AlertError = "#fb4934";
          Title = "#d79921";
          Muted = "#928374";
          SyntaxCommand = "#b8bb26";
          SyntaxFlag = "#fabd2f";
          SyntaxString = "#b8bb26";
          SyntaxVariable = "#83a598";
          SyntaxOperator = "#fe8019";
          SyntaxComment = "#928374";
        };
      };
    };
  };
}
