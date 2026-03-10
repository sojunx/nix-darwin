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
      enableZshIntegration = true;
      settings = {
        theme = "jellybeans";
        font-family = "JetBrainsMono Nerd Font";
        font-style = "Bold";
        font-size = 14;
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

      shellAliases = {
        cat = "bat --style=numbers --color=always";
        ls = "eza";
        ll = "eza -l";
        la = "eza -la";
        vim = "nvim";
        vi = "nvim";
      };
    };
  };

  home.stateVersion = "25.11";
}
