{
  description = "Static ARMv7 framebuffer terminals for Braiins Deck";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fbterm-src = {
      url = "github:BraiinsForge/fbterm-fork";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, fbterm-src }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    crossPkgs = pkgs.pkgsCross.armv7l-hf-multiplatform.pkgsStatic;
  in {
    packages.x86_64-linux = {
      default = self.packages.x86_64-linux.fbterm;

      fbterm = crossPkgs.fbterm.overrideAttrs (old: {
        src = fbterm-src;
      });

      yaft = crossPkgs.yaft.overrideAttrs (old: {
        # Fix cross-compilation: mkfont_bdf needs to run on build host
        depsBuildBuild = [ pkgs.buildPackages.stdenv.cc ];
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.ncurses ];
        preBuild = ''
          # Build mkfont_bdf for the build host (x86_64), not target (armv7)
          ${pkgs.buildPackages.stdenv.cc}/bin/cc -o mkfont_bdf tools/mkfont_bdf.c -std=c99 -pedantic -Wall -Wextra -O3 -pipe
        '';
      });
    };
  };
}

# command: ./bin/fbterm -r 3 -n "ProFontExtended" -s 15 --font-width 11 -a -- htop < /dev/tty1 > /dev/tty1 2>&1
