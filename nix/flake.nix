{
  description = "A nix-flake for nix development environments";

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
        packages = with pkgs; [
          statix
          vulnix
          cachix
          nixfmt-rfc-style
        ];
      in
      {
        devShells.default = pkgs.mkShell { inherit packages buildInputs nativeBuildInputs; };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
