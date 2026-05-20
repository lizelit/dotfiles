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
      dev = "zmx attach dev";
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
    functions -c fish_prompt _original_fish_prompt 2>/dev/null

    function r
      set -l contest (basename (pwd))
      cargo run --manifest-path ../Cargo.toml -p $contest --bin $argv[1]
    end

     function mkc
      set -l contest $argv[1]
      cargo new $contest
      rm $contest/src/main.rs
      mkdir -p $contest/src/bin

      echo "[package]
name = \"$contest\"
version = \"0.1.0\"
edition = \"2021\"

[dependencies]
proconio.workspace = true
superslice.workspace = true
num.workspace = true" > $contest/Cargo.toml

      for prob in a b c d e f g
          echo "use proconio::input;
use superslice::Ext;
use num::integer::gcd;

fn main() {
    input! {
        // 入力をここに
    }
}" > $contest/src/bin/$prob.rs
      end

      # Nix環境でも確実に動くように、ワンライナーの perl（または拡張sed）で members の末尾に追記
      if test -f Cargo.toml
          # ] の手前にインデント付きで新しいクレート名を追加
          perl -i -pe "s/^(\s*)]/    \"$contest\",\n\$1]/" Cargo.toml
      end
    end
    function fish_prompt --description 'Write out the prompt'
      if set -q ZMX_SESSION
        echo -n "[$ZMX_SESSION] "
      end
      _original_fish_prompt
    end
  '';
  };
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

