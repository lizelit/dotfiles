{username, ... }:

{
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["${username}" "root" "@admin"];
    };

    optimise = {
      automatic = true;
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-that 30d";
    };
  };
}
