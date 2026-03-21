{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    curl
    tree
    docker
    colima
    docker-compose
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh.enable = true;

  system = {
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    primaryUser = "sojunx";

    defaults = {
      dock = {
        autohide = true;
        minimize-to-application = true;
        show-recents = false;
        tilesize = 48;
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Arc.app"
          "/Applications/Obsidian.app"
          "/Applications/Discord.app"
          "/System/Applications/Music.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Ghostty.app"
          "/Applications/Apidog.app"
        ];
      };
    };
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = [
      "arc"
      "discord"
      "visual-studio-code"
      "raycast"
      "ghostty"
      "obsidian"
      "apidog"
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
    ];
  };

  users.users.sojunx.home = "/Users/sojunx";
}
