{ config, pkgs, inputs, username, hostname, homeDirectory, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/nix.nix
    ./modules/programs.nix
    ./modules/homebrew.nix
    ./modules/desktop.nix
  ];

  ids.gids.nixld = 350;
  system.primaryUser = username;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    hostPlatform = "aarch64-darwin";
  };
}
