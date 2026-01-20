{ ... }:

{
  programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
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
