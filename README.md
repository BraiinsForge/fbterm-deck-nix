# fbterm for Braiins Deck

Static ARMv7 build of fbterm for use on the Braiins Deck.

## Build

```sh
nix build
```

The binary will be at `./result/bin/fbterm`.

## Deploy to Deck

1. Copy the binary to the Deck:
   ```sh
   scp ./result/bin/fbterm root@<ip>:/tmp/
   ```

2. Copy fonts to the Deck (fbterm uses fontconfig):
   ```sh
   scp -r /path/to/your/fonts root@<ip>:/tmp/fonts
   ```

   Then on the Deck:
   ```sh
   cp -r /tmp/fonts/* /usr/share/fonts/
   ```

## Run

```sh
/tmp/fbterm -r 3 -n "ProFontExtended" -s 15 --font-width 11 -a -- htop < /dev/tty1 > /dev/tty1 2>&1
```

- `-r 3` rotates the screen 270° (landscape mode for the Deck's display)
- `-n "ProFontExtended"` sets the font (adjust to whatever you uploaded)
- `-s 15` sets font size
- `--font-width 11` adjusts character width
- `-a` enables anti-aliasing
