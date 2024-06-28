{
  description = "Flake for Python Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    poetry2nix,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pythonVersion = "python311";
    packages = ps:
      with ps; [
        dash
        flask
        matplotlib
        numba
        numba-scipy
        numpy
        opencv4
        pandas
        pillow
        plotly
        requests
        scikit-image
        scipy
        #streamlit
        qrcode
      ];
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.${pythonVersion}
        (pkgs.${pythonVersion}.withPackages packages)
        pkgs.zlib
      ];

      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH";

      shellHook = ''
        echo "Python Env"
      '';
    };
  };
}
