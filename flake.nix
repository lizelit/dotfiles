{
  description = "Darwin system with NixVim and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nixvim, neovim-nightly-overlay, ... }@inputs: {
    darwinConfigurations."Mac-2" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs;
        username = "lizelit";
        hostname = "Mac-2";
        homeDirectory = "/Users/lizelit";
      };
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.lizelit = import ./home.nix;
            # NixVimをHome-ManagerのsharedModulesとしてインポート
            sharedModules = [
              nixvim.homeModules.nixvim
            ];
          };
        }
      ];
    };
  };
}
