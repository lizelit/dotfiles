{ ... }:

{
  programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      numberwidth = 6;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      # showtabline = 1;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      hidden = false;
      bufhidden = "wipe";
    };

    autoCmd = [
      {
        event = [ "InsertLeave" ];
        pattern = [ "*" ];
        command = "silent !macism com.apple.keylayout.ABC";
      }
    ];
  };
}
