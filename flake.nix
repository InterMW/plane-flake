{
  description = "Nixos flake to acquire plane info";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.getmac.url = "github:InterMW/mac-flake";

  outputs = { self, nixpkgs,  getmac}:
    let
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";
      version = builtins.substring 0 8 lastModifiedDate;
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });
    in
    {
	overlay = final: prev: {
		dumpmutability = with final; stdenv.mkDerivation rec {
		  pname = "dump1080";
		  inherit version;

		  src = ./.;

		  nativeBuildInputs = [ autoreconfHook  
		    rabbitmq-c
                    codespell
		    rtl-sdr-osmocom
			pkg-config];
		};

	};
	
      defaultPackage = forAllSystems (system: self.packages.${system}.dumpmutability     );
      # Provide some binary packages for selected system types.
      packages = forAllSystems (system:
        {
          inherit (nixpkgsFor.${system}) dumpmutability;
        });
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default =
            pkgs.mkShell.override
              {
                # Override stdenv in order to change compiler:
                # stdenv = pkgs.clangStdenv;
              }
              {
                packages =
                  with pkgs;
                  [
                    clang-tools
                    cmake
		    rabbitmq-c
                    codespell
		    rtl-sdr-osmocom
			pkg-config
                    vcpkg
                    vcpkg-tool
                  ]
                  ++ (if system == "aarch64-darwin" then [ ] else [ gdb ]);
              };
        }
      );
      nixosModules.dumpmutability =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ self.overlay ];

          environment.systemPackages = [ pkgs.dumpmutability pkgs.rabbitmq-c pkgs.rtl-sdr-librtlsdr];

          #systemd.services = { ... };
        };
    };

}

