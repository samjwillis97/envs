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
        pkgs = import nixpkgs { inherit system; };
        packages = with pkgs; [
          dotnet-sdk_8
          msbuild
        ];
      in
      {
        devShells.default = pkgs.mkShell { inherit packages; };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
