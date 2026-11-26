{ config, lib, ... }:

{
  programs.omniwm = {
      enable = true;
      settings = ./settings.toml;
  };

  # home.activation.omniwmSettings =
  #   lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #     mkdir -p "$HOME/.config/omniwm"
  #     cp ${./settings.toml} "$HOME/.config/omniwm/settings.toml"
  #     chmod 644 "$HOME/.config/omniwm/settings.toml"
  #   '';
}
