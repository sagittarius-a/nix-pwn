
{
  description = "Pwn environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pwndbg.url = "github:pwndbg/pwndbg";
  };

  outputs = { nixpkgs, pwndbg, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      /**
        Return the Pwn toolchain for a given package set.

        # Arguments

        pkgs
        : Nixpkgs package set for the target system.

      */
      pwnPackages = pkgs:
        import ./packages.nix {
          inherit pkgs;

          pwndbgPackage =
            pwndbg.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
    in
    {
      # Persistent installation via Home Manager
      homeModules.default = { pkgs, ... }: {
        home.packages = pwnPackages pkgs;
      };

      # Temporary environment via nix develop
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = pwnPackages pkgs;
          };
        }
      );
    };
}

