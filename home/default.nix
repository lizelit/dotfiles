{ config, lib, inputs, pkgs, username, homeDirectory, nixvim, ... }:

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
    ./modules/development.nix
    ./modules/helix.nix
    ./modules/nixvim
    ./modules/terminal.nix
    ./modules/utilities.nix
    ./modules/zellij.nix
    ./modules/omniwm
    ./modules/ghostty.nix
  ];
}
