{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
    git
    delta
    git-filter-repo
    diff-so-fancy
    difftastic
    lazygit
    git-lfs
  ];

  programs.git = {
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
}
