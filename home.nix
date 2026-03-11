{ pkgs, ... }:
{
  home.username = "sojunx";
  home.homeDirectory = "/Users/sojunx";

  home.packages = with pkgs; [
    nodejs
    python3
    go
    cargo
    nil
    nixfmt

    ripgrep
    fd
    unzip
  ];
  home.file.".hushlogin".text = "";

  xdg.configFile."nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "sojunx";
      repo = "nvim";
      rev = "version-2";
      sha256 = "sha256-krkrLj22F+fgq44dlL1XYt3Z8BxGlNI5LCRxqv5WZv8=";
    };
    recursive = true;
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      settings = {
        user.name = "sojunx";
        user.email = "phatlee1104@gmail.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    bat = {
      enable = true;
      config.theme = "Catppuccin Mocha";
      themes = {
        "Catppuccin Mocha" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };

    ghostty = {
      enable = true;
      package = null;
      settings = {
        theme = "jellybeans";
        font-family = "JetBrainsMono Nerd Font";
        font-size = 15;
        background-opacity = 0.75;
        background-blur-radius = 30;
        macos-titlebar-proxy-icon = "hidden";
        macos-titlebar-style = "hidden";
        adjust-cursor-thickness = 1;
      };
      themes = {
        jellybeans = {
          background = "121212";
          foreground = "dedede";
          selection-background = "474e91";
          selection-foreground = "f4f4f4";
          cursor-color = "ffa560";
          cursor-text = "ffffff";
          palette = [
            "0=#929292"
            "1=#e27373"
            "2=#94b979"
            "3=#ffba7b"
            "4=#97bedc"
            "5=#e1c0fa"
            "6=#00988e"
            "7=#dedede"
            "8=#bdbdbd"
            "9=#ffa1a1"
            "10=#bddeab"
            "11=#ffdca0"
            "12=#b1d8f6"
            "13=#fbdaff"
            "14=#1ab2a8"
            "15=#ffffff"
          ];
        };
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;

      # direnv.toml — tweak warn timeout, etc.
      config = {
        global = {
          warn_timeout = "30s";
          hide_env_diff = true; # show what env vars changed
        };
      };
    };

    eza = {
      enable = true;
      git = true;
      icons = "always";
      enableZshIntegration = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          serverAliveInterval = 60;
          serverAliveCountMax = 3;
        };
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };

    tmux = {
      enable = true;
      mouse = true;
      prefix = "C-a";
      keyMode = "vi";
      terminal = "tmux-256color";
      escapeTime = 0;
      baseIndex = 1;

      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        {
          plugin = yank;
          extraConfig = ''
            set -g @yank_selection_mouse 'clipboard'
          '';
        }
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_status_style "basic"
            set -g @catppuccin_window_current_text_color "#{@thm_surface_1}"
            set -g @catppuccin_window_current_number_color "#{@thm_peach}"
            set -g @catppuccin_window_current_text "#[bg=#{@thm_mantle}] #{b:pane_current_path}"
            set -g @catppuccin_window_text " #W"
            set -g @catppuccin_window_default_text "#W"
            set -g @catppuccin_window_number_color "#{@thm_lavender}"
          '';
        }
      ];

      extraConfig = ''
        # True color
        set -ag terminal-overrides ",xterm-256color:RGB"

        # Prefix
        bind-key C-a send-prefix

        # Reload config
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        # Resize panes
        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r h resize-pane -L 5
        bind -r l resize-pane -R 5
        bind -r m resize-pane -Z

        # Splits
        unbind %
        bind '\' split-window -h -c '#{pane_current_path}'
        unbind '"'
        bind - split-window -v -c '#{pane_current_path}'
        bind c new-window -c '#{pane_current_path}'
        bind -r v split-window -h -c "#{pane_current_path}" "zsh -c 'nvim; exec zsh'"

        # Windows
        set-option -g renumber-windows on

        # Status bar
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application} #{E:@catppuccin_status_session}"
        set -g window-status-separator ""
        set -g status-style bg=default
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };

      history = {
        path = "$HOME/.zhistory";
        save = 1000;
        size = 999;
        share = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
      };

      shellAliases = {
        cat = "bat --style=numbers --color=always";
        ls = "eza";
        ll = "eza -l";
        la = "eza -la";
        vim = "nvim";
        vi = "nvim";
        "nix-rebuild" = "sudo darwin-rebuild switch --flake";
      };

      initContent = ''
        setopt hist_verify

        # Keymap
        bindkey '[C' forward-word
        bindkey '[D' backward-word
        bindkey '^[[A' history-search-backward
        bindkey '^[[B' history-search-forward
      '';
    };
  };

  home.stateVersion = "25.11";
}
