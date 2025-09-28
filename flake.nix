{
  description = "My personal Darwin system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, neovim-nightly-overlay, ... }: 
  let
    system = "aarch64-darwin";
    
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ neovim-nightly-overlay.overlays.default ];
    };
    
    username = "lizelit";
    hostname = "Mac";
    homeDirectory = "/Users/${username}";
  in
  {
    # Darwin configuration
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          # home-manager integration
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = import ./home.nix;
          
          home-manager.extraSpecialArgs = { 
            inherit inputs username homeDirectory pkgs; 
          };
          
          users.users.${username} = {
            name = username;
            home = homeDirectory;
          };
        }
      ];
      specialArgs = { 
        inherit inputs username hostname homeDirectory pkgs; 
      };
    };

    # Home configuration (standalone)
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = { 
        inherit inputs username homeDirectory pkgs; 
      };
    };
  };
}
