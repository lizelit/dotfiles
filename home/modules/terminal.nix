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

      g = "git";
      lg = "lazygit";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      e = "$EDITOR";
      dr = "sudo darwin-rebuild switch --flake ~/dotfiles";
      fk = "f";
    };

    shellInit = ''
      fish_add_path -P /opt/homebrew/bin
      fish_add_path -P /opt/homebrew/sbin

      fish_vi_key_bindings

      set -g theme_display_vi yes

      set -g theme_display_user no
      set -g theme_display_hostname no

      if status is-interactive
        if not set -q  ZELLIJ
          if zellij list-sessions 2>/dev/null | string match -q "*dev*"
              zellij attach dev
          else
              zellij --session dev
          end
        end
      end

      if test -f "${config.age.secrets.ai_token.path}"
        set -gx COPILOT_API_KEY (cat "${config.age.secrets.ai_token.path}")
        set -gx HANDLER copilot
      end
    '';
  };
}
