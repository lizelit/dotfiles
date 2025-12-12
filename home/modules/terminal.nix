{ config, pkgs, ... }:

{
  programs.zsh.enable = false;

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

    initContent = ''
      fish_vi_mode
      
      if not set -q ZELLIJ_PANE_ID
          zellij attach dev 2>/dev/null
          if test $status -ne 0
              zellij --session dev
          end
      end
    '';
  };
}
