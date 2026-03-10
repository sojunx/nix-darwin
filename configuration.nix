{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [ neovim ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;

  users.users.sojunx.home = "/Users/sojunx";
}
