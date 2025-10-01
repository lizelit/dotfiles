{
  description = "My personal Darwin system configuration";

  inputs = {
    # 1. Nixpkgs: すべてのパッケージの源
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # 2. Nix-Darwin: macOSシステム設定の管理
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # 3. Home Manager: ユーザー環境の設定を管理
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05"; # バージョン指定を推奨
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # 4. NixVim: Neovimの設定モジュール
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nixvim, ... }: 
  let
    # 🍎 あなたのシステムアーキテクチャに合わせて設定
    system = "aarch64-darwin"; 
    
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    
    username = "lizelit";
    hostname = "Mac-2";
    homeDirectory = "/Users/${username}";
  in
  {
    # 🌟 Darwin system configuration
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager # nix-darwin経由でHome Managerをインポート
        {
          # Home Managerの設定ブロック
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          
          # ユーザーの設定ファイル
          home-manager.users.${username} = {
          };
          home-manager.modules = [
            ./home.nix
            nixvim.homeModules.nixvim
          ];
        }
      ];
      specialArgs = { 
        inherit inputs username hostname homeDirectory pkgs; 
      };
    };
  };
}
