{ config, lib, inputs, pkgs, username, homeDirectory, ... }:

let
  decryptedTokenPath = config.age.secrets.ai_token.path;
in {
  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;
  home.stateVersion = "25.11";
  home.activation.checkAppManagementPermission = lib.mkForce "";

  programs.home-manager.enable = true;

  age.secrets.ai_token = {
    file = "${inputs.self}/secrets/ai_token.age";
  };

  imports = [
    ./modules/alacritty.nix
    ./modules/base.nix
    ./modules/btop.nix
    ./modules/development.nix
    ./modules/editors.nix
    ./modules/terminal.nix
    ./modules/utilities.nix
    ./modules/zellij.nix
    ./modules/window-manager.nix
  ];
}
