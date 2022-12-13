# Advent of Code 2022 - Nintendo DS ASM

This is a (late start) repository for Advent of Code 2022. All solutions are written in ARM assembly for the Nintendo DS, facilitated by devkitPro's DevkitARM toolchain.

The root of the repository contains a common source file `common.s`, which simply loads the flavour-text style image to the top screen and sets up the bottom screen for console printing.
The image `topscreen.png` is converted to binary data in assembly format by the tool GRIT, part of the toolchain. Normally, I like to have all resources in NitroFS to be dynamically loaded rather than loading everything into memory (one of my main gripes with NDS homebrew), but the scope of the project means it's fine for this case.

All solutions aim to use a minimal number of source files for simplicity's sake, although this may change where necessary.

## Licensing

The entire contents of this repository is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.
