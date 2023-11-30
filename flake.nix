{
  description = "Flake for Python Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
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
        pkgs.python3
        (pkgs.python3.withPackages packages)
      ];

      shelHook = ''
        echo "Python Env"
      '';
    };
  };
}
