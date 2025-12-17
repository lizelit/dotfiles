{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "kanagawa";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        completion-trigger-len = 1;
        completion-timeout = 2;
        trim-trailing-whitespace = true;
        auto-info = true;
      };

      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      editor.file-picker = {
        hidden = false;
      };

      editor.lsp = {
        enable = true;
        display-messages = true;
        display-inlay-hints = true;
        auto-signature-help = true;
        display-signature-help-docs = true;
        snippets = true;
        goto-reference-include-declaration = true;
      };

      editor.soft-wrap = {
        enable = true;
      };

      editor.indent-guides = {
        render = true;
      };

      editor.statusline = {
        left = ["mode" "spinner" "version-control" "file-name" "file-modification-indicator"];
        center = [];
        right = ["diagnostics" "selections" "position" "file-encoding"];
        separator = "│";
      };

      keys.insert = {
        "esc" = [":sh macism com.apple.keylayout.ABC" "normal_mode"];
      };

    };
    languages = {
      language-server.gpt = {
        command = "helix-gpt";
      };
      language-server.rs = {
        command = "rust-analyzer";
      };
      language-server.typ = {
        command = "tinymist";
      };
      language-server.rb = {
        command = "$RUBY_LSP_BIN";
      };
      language = [
        {
          name = "rust";
          language-servers = ["rs" "gpt"];
        }
        {
          name = "typst";
          language-servers = ["typ" "gpt"];
        }
      ];
    };
  };
}
