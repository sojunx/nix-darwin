{ config, pkgs, ... }:
{
  home.username = "sojunx";
  home.homeDirectory = "/Users/sojunx";

  # home.packages = with pkgs; [ bat ];

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      settings = {
      	user.name = "sojunx";
	user.email = "phathieple1104@gmail.com";
	init.defaultBranch = "main";
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

    eza = {
      enable = true;
      git = true;
      colors = "always";
      icons = "always";
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  home.stateVersion = "25.11";
}
