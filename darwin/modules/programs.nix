{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    pkg-config
    cmake
    git
    curl
    wget
  ];

  programs = {
    fish.enable = true;
  };
}
