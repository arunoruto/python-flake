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
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";

      buildInputs = [
        pkgs.${pythonVersion}
        (pkgs.${pythonVersion}.withPackages packages)
      ];

      shellHook = ''
        echo "Python Env"
      '';
    };
  };
}
