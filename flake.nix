{
  description = "Static ARMv7 fbterm (BGR colors)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fbterm-src = {
      url = "github:BraiinsForge/fbterm-fork";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, fbterm-src }: {
    packages.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      crossPkgs = pkgs.pkgsCross.armv7l-hf-multiplatform.pkgsStatic;
    in crossPkgs.fbterm.overrideAttrs (old: {
      src = fbterm-src;
    });
  };
}

# command: ./bin/fbterm -r 3 -n "ProFontExtended" -s 15 --font-width 11 -a -- htop < /dev/tty1 > /dev/tty1 2>&1
