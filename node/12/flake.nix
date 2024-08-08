{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    old_nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/f597e7e9fcf37d8ed14a12835ede0a7d362314bd.tar.gz";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      old_nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ ];
        pkgs = import nixpkgs { inherit system overlays; };

        old_pkgs = import old_nixpkgs {
          inherit system overlays;

          config.permittedInsecurePackages = [ "nodejs-12.22.12" ];
        };

        nativeBuildInputs = with pkgs; [ ];
        buildInputs = with pkgs; [ ];
        packages = [ old_pkgs.nodejs-12_x ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit packages buildInputs nativeBuildInputs;
          shellHook = ''
            export PATH="$PATH:$PWD/node_modules/.bin"
          '';
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
