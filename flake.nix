{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          version = "0.1.4";
        in
        with pkgs;
        {
          packages = rec {
            importer = buildGoModule {
                pname = "importer";
                inherit version;

                src = fetchFromGitHub {
                  owner = "upsidr";
                  repo = "importer";
                  rev = "v${version}";
                  sha256 = "sha256-LWWs3zSLlq6P5SFdUbauL/fZPGgUmb2nlkf88Wy1+/M=";

                };

                vendorHash = "sha256-622Dz9m4q6KMXKbMiCKeVfjhdhKX8+TQzZecby3b83s=";

                meta = with lib; {
                  description = "Import any lines, from anywhere";
                  homepage = "https://github.com/upsidr/importer/tree/main";
                  changelog = "https://github.com/upsidr/importer/releases";
                  license = licenses.asl20;
                  maintainers = with maintainers; [ e346m ];
                  mainProgram = "importer";
                };
            };
            defaultPackage = importer;
          };
        }
      );
  }
