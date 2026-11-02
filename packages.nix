
{ pkgs, pwndbgPackage }:

with pkgs; [
  # Debugging
  gdb
  pwndbgPackage

  # Reverse engineering
  radare2
  binutils
  file

  # Exploitation
  (python3.withPackages (ps: with ps; [
    pwntools
  ]))

  # Utilities
  patchelf
  strace
  ltrace
  checksec
]

