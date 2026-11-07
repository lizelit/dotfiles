{ username, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/nix.nix
    ./modules/programs.nix
    ./modules/homebrew.nix
    ./modules/stylix.nix
  ];

  system.primaryUser = username;

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };
}
