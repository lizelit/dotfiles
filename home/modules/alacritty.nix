{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = { x = 10; y = 4; };
        dynamic_padding = true;
        opacity = 1.0;
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
