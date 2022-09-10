{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      source = import ./_sources/generated.nix {inherit (pkgs) fetchgit fetchurl fetchFromGitHub;};

      revanced-cli = pkgs.stdenv.mkDerivation rec {
        inherit (source.revanced-cli) pname src version;

        nativeBuildInputs = [];

        unpackCmd = "mkdir src; cp $curSrc src";

        installPhase = ''
          mkdir -p $out
          mv *.jar $out/revanced-cli.jar
        '';
      };

      revanced-patches = pkgs.stdenv.mkDerivation rec {
        inherit (source.revanced-patches) pname src version;

        nativeBuildInputs = [];

        unpackCmd = "mkdir src; cp $curSrc src";

        installPhase = ''
          mkdir -p $out
          mv *.jar $out/revanced-patches.jar
        '';
      };

      revanced-integrations = pkgs.stdenv.mkDerivation rec {
        inherit (source.revanced-integrations) pname src version;

        nativeBuildInputs = [];

        unpackCmd = "mkdir src; cp $curSrc src";

        installPhase = ''
          mkdir -p $out
          mv *app-release-unsigned.apk $out/app-release-unsigned.apk
        '';
      };
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.bashInteractive
          pkgs.openjdk
          pkgs.haskellPackages.nvfetcher
          (pkgs.stdenv.mkDerivation {
            name = "rv-patch";
            unpackPhase = "true";
            buildInputs = [revanced-patches revanced-integrations revanced-cli];
            installPhase = ''
              mkdir -p $out/bin
              {
                echo '#!/usr/bin/env bash'
                echo 'java -jar \
                 	${revanced-cli}/revanced-cli.jar \
                -b ${revanced-patches}/revanced-patches.jar \
                -m ${revanced-integrations}/app-release-unsigned.apk "$@"'
              } > $out/bin/rv-patch
              chmod +x $out/bin/rv-patch
            '';
          })
        ];
        buildInputs = [];
      };
    });
}
