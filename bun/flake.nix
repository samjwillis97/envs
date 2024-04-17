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
        buildInputs = with pkgs; [ ];
        packages = with pkgs; [ bun ];
      in
      with pkgs;
      {
        devShells.default = mkShell { inherit packages buildInputs nativeBuildInputs; };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
