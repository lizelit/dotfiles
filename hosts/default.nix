{ inputs, ... }:

let
  inherit (inputs) nixpkgs nix-darwin home-manager;

  username = "lizelit";
  hostname = "TMBA-2";
  homeDirectory = "/Users/${username}";

  aiTokens = import (inputs.self + "/secrets/ai-tokens.nix");

  specialArgs = {
    inherit inputs username hostname homeDirectory;
    aiTokens = aiTokens;
  };

  darwinConfigs = {
    "${hostname}" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      inherit specialArgs;

      modules = [
        ../darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username} = import ../home;
            sharedModules = [ ];
          };
        }
      ];
    };
  };
in
{
  darwinConfigurations = darwinConfigs;
  darwinConfiguration = darwinConfigs."${hostname}";
}
