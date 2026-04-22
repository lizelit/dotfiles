{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = { x = 8; y = 4; };
        dynamic_padding = true;
        blur = true;
        decorations = "Buttonless";
        option_as_alt = "Both";
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };
}
