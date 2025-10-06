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
  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nixvim,
    ...
  } @ inputs: let
    username = "lizelit";
    hostname = "Mac-2";
    homeDirectory = "/Users/lizelit";
    specialArgs = {
      inherit inputs username hostname homeDirectory;
    };
  in {
    darwinConfigurations."Mac-2" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      inherit specialArgs;
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.lizelit = import ./home.nix;
            sharedModules = [
              nixvim.homeModules.nixvim
            ];
          };
        }
      ];
    };
  };
}
