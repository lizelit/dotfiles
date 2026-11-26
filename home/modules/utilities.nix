{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd skim bat delta eza fastfetch
    bottom
    yazi lazygit zellij
    nix-search-cli
    ghq
    btop
  ];

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # enableFishIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  programs.gh = {
    enable = true;
  };

  programs.gh-dash = {
    enable = true;
  };

  programs.skim = {
    enable = true;
    enableFishIntegration = true;
  };
}
