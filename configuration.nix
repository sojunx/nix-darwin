{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
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
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
    ];
  };

  users.users.sojunx.home = "/Users/sojunx";
}
