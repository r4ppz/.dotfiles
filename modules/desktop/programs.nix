_:

{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };
      };
    };

    waybar = {
      enable = true;
      systemd.enable = true;
    };

    brave-origin = {
      enable = true;
      extensions = [
        { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium C
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      ];
      commandLineArgs = [
        "--disable-features=WaylandWpColorManagerV1"
        "--ozone-platform-hint=auto"
        "--enable-features=OverlayScrollbar,RootScrollbarFollowsBrowserTheme"
        "--disable-smooth-scrolling"
        "--force-prefers-reduced-motion"
      ];
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

    btop = {
      enable = true;
      settings = {
        color_theme = "modified_gruvbox";
        theme_background = false;
        rounded_corners = false;

        update_ms = 1000;
        shown_boxes = "cpu mem proc net";

        proc_gradient = false;
        proc_aggregate = true;
        cpu_graph_upper = "total";

        show_disks = false;
        io_mode = true;

        vim_keys = true;
        base_10_bitrate = "True";

        show_gpu_info = "On";
        shown_gpus = "nvidia amd intel";

        # needed for nixifiedshit
        save_config_on_exit = false;
      };

      themes.modified_gruvbox = ''
        theme[main_bg]=""
        theme[main_fg]="#d4be98"
        theme[title]="#d4be98"
        theme[hi_fg]="#ea6962"
        theme[selected_bg]="#83A598"
        theme[selected_fg]="#282828"
        theme[inactive_fg]="#282828"
        theme[graph_text]="#665c54"
        theme[proc_misc]="#a9b665"
        theme[cpu_box]="#7C6F64"
        theme[mem_box]="#7C6F64"
        theme[net_box]="#7C6F64"
        theme[proc_box]="#7C6F64"
        theme[div_line]="#7C6F64"
        theme[temp_start]="#83A598"
        theme[temp_mid]="#e78a4e"
        theme[temp_end]="#ea6962"
        theme[cpu_start]="#a9b665"
        theme[cpu_mid]="#d8a657"
        theme[cpu_end]="#ea6962"
        theme[free_start]="#89b482"
        theme[free_mid]=""
        theme[free_end]=""
        theme[cached_start]="#83A598"
        theme[cached_mid]=""
        theme[cached_end]=""
        theme[available_start]="#d8a657"
        theme[available_mid]=""
        theme[available_end]=""
        theme[used_start]="#ea6962"
        theme[used_mid]=""
        theme[used_end]=""
        theme[download_start]="#e78a4e"
        theme[download_mid]=""
        theme[download_end]=""
        theme[upload_start]="#d3869b"
        theme[upload_mid]=""
        theme[upload_end]=""
      '';
    };

  };
}
