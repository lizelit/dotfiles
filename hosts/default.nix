{ inputs, ... }:

let
  inherit (inputs) nixpkgs nix-darwin home-manager agenix stylix nixvim;

  username = "lizelit";
  hostname = "TMBA-2";
  homeDirectory = "/Users/${username}";

  aiTokens = import (inputs.self + "/secrets/ai-tokens.nix");

  specialArgs = {
    inherit inputs username hostname homeDirectory aiTokens;
  };

  darwinConfigs = {
    "${hostname}" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      inherit specialArgs;

      modules = [
        ../darwin
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
        stylix.darwinModules.stylix
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username} = import ../home;
            sharedModules = [
              agenix.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
            ];
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
