{ config, lib, pkgs, ... }:

{
  programs.omniwm = {
      enable = true;

      settings =
        builtins.fromTOML
          (builtins.readFile ./settings.toml);
    };
}
