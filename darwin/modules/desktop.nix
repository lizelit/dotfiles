{ pkgs, ... }:

{
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      window_shadow = false;
      window_topmost = true;
      window_gap = 2;
      top_padding = 0;
      bottom_padding = 0;
      left_padding = 0;
      right_padding = 0;
      layout = "bsp";
    };
    extraConfig = ''
      yabai -m config focus_follows_mouse autoraise
      yabai -m config mouse_follows_focus on
      yabai -m rule --add app="Finder" manage=off
      yabai -m rule --add app="System Settings" manage=off
      yabai -m rule --add app="Spotify" manage=off
      yabai -m rule --add app="Discord" manage=off
      yabai -m rule --add app="Slack" manage=off
      yabai -m rule --add app="Mail" manage=off
      yabai -m signal --add event=window_focused \
        app="^Alacritty$" \
        action="/opt/homebrew/bin/macism com.apple.keylayout.ABC"
      yabai -m signal --add event=application_front_switched \
        app="^Alacritty$" \
        action="/opt/homebrew/bin/macism com.apple.keylayout.ABC"
    '';
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      ctrl + cmd - t : open -a "Alacritty"
      ctrl + cmd - b : open -a "zen"
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east
      shift + alt - left : yabai -m display --focus prev
      shift + alt - right : yabai -m display --focus next
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east
    '';
  };
}
