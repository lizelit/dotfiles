{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    preferAbbrs = true;

    shellAbbrs = {
      ls = "eza";
      la = "eza -la";
      lt = "eza --tree --git-ignore";
      tree = "eza --tree --git-ignore";
      cat = "bat";
      grep = "rg";
      cd = "z";
      vim = "nvim";
      vi = "nvim";

      g = "lazygit";
      lg = "lazygit";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      e = "$EDITOR";
      dr = "sudo darwin-rebuild switch --flake ~/dotfiles";
      fk = "f";
      dev = "zellij attach -c dev";
    };

    shellInit = ''
    fish_add_path -P /opt/homebrew/bin /opt/homebrew/sbin
    fish_add_path -P ~/.cargo/bin

    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
    if test -d $GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin
        fish_add_path -P $GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin
    end

    fish_vi_key_bindings
    set -g theme_display_vi yes
    set -g theme_display_user no
    set -g theme_display_hostname no

    if test -f "${config.age.secrets.ai_token.path}"
        set -gx COPILOT_API_KEY (cat "${config.age.secrets.ai_token.path}")
        set -gx HANDLER copilot
    end
  '';  };
}
    # set -gx SDKROOT (xcrun --show-sdk-path)
    # set -gx LIBRARY_PATH $LIBRARY_PATH /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

# if status is-interactive
#   if not set -q ZELLIJ; and not set -q IS_QUICK_TERMINAL
#     if zellij list-sessions 2>/dev/null | string match -q "*dev*"
#         zellij attach dev
#     else
#         zellij --session dev
#     end
#   end
# end

