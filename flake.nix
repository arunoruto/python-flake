{
  description = "Flake for Python Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pythonVersion = "python311";
    packages = ps: with ps; [
      matplotlib
      numba
      numpy
      opencv4
      pandas
      pillow
      requests
      scikit-image
      streamlit
    ];
  in
  {
    devShells.${system}.default = pkgs.mkShell {
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
