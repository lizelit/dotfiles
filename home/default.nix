{ config, lib, pkgs, username, homeDirectory, ... }@specialArgs:

let
  aiTokens = specialArgs.aiTokens;
in {
  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;
  home.stateVersion = "25.11";
  home.activation.checkAppManagementPermission = lib.mkForce "";

  programs.home-manager.enable = true;

  imports = [
    ./modules/alacritty.nix
    ./modules/base.nix
    ./modules/btop.nix
    ./modules/development.nix
    ./modules/editors.nix
    ./modules/terminal.nix
    ./modules/utilities.nix
    ./modules/zellij.nix
  ];

  home.sessionVariables = {
    COPILOT_API_KEY = aiTokens.copilotApiKey;
  };
}
