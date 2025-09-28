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
    
    # nix-homebrewを追加
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, neovim-nightly-overlay, ... }: 
  let
    system = "aarch64-darwin"; # Intel Mac用
    
    # overlayを適用したpkgsを作成
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ neovim-nightly-overlay.overlays.default ];
    };
    
    # 共通の設定値
    username = "lizelit";  # 実際のユーザー名に変更
    hostname = "Mac";      # 実際のホスト名に変更
    homeDirectory = "/Users/${username}";
  in
  {
    # Darwin configuration
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./darwin.nix
        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # ユーザーを指定
            user = username;
            # 既存のHomebrewインストールを自動移行
            autoMigrate = true;
            # Apple Silicon用のパスを明示的に指定
            mutableTaps = false;
            taps = {
              "homebrew/homebrew-core" = inputs.nix-homebrew.inputs.brew-src;
            };
          };
        }
        home-manager.darwinModules.home-manager
        {
          # home-manager の統合設定
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = import ./home.nix;
          
          # home-managerにspecialArgsとpkgsを渡す
          home-manager.extraSpecialArgs = { 
            inherit inputs username homeDirectory pkgs; 
          };
          
          # ユーザー情報の共有
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

    # Home configuration (standalone用)
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = { 
        inherit inputs username homeDirectory pkgs; 
      };
    };
  };
}
