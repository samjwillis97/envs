{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ ];
        pkgs = import nixpkgs { inherit system overlays; };

        nativeBuildInputs = with pkgs; [ ];
        buildInputs = with pkgs; [ nodejs_20 ];
      in
      with pkgs;
      {
        devShells.default = mkShell { inherit buildInputs nativeBuildInputs; };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
