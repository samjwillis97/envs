{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    old_nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
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

          config.permittedInsecurePackages = [
            "nodejs-14.21.3"
            "openssl-1.1.1w"
          ];
        };

        nativeBuildInputs = with pkgs; [ ];
        buildInputs = with pkgs; [ ];
        packages = [ old_pkgs.nodejs_14 ];
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
