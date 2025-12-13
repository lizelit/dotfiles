{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.fish = {
    enable = true;

    functions = {
      ls = "eza"; la = "eza -la"; lt = "eza --tree"; cat = "bat"; grep = "rg";
      spp = "spotify_player";

      g = "git"; gs = "git status"; ga = "git add"; gc = "git commit"; gp = "git push"; gl = "git pull";

      nr = "nix run"; ns = "nix shell"; nf = "nix flake";
      e = "$EDITOR";

      dr = ''
        function dr
          sudo darwin-rebuild switch --flake ~/dotfiles
        end
      '';
    };

    shellInit = ''
      fish_add_path -P /opt/homebrew/bin
      fish_add_path -P /opt/homebrew/sbin

      if status is-interactive
        if not set -q  ZELLIJ
          if zellij list-sessions 2>/dev/null | string match -q "*dev*"
              zellij attach dev
          else
              zellij --session dev
          end
        end
      end

    '';
  };
}
