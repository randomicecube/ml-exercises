{
  description = "Dev environment for ML Exercises 2022/2023";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    mach-nix.url = "mach-nix";
  };

  outputs = { self, nixpkgs, mach-nix }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      machNix = mach-nix.lib."${system}";
      myPython = machNix.mkPython {
        requirements = ''
          numpy
          pandas
          matplotlib
          seaborn
          scikit-learn
          scipy
          varname
          ipykernel
        '';
      };
    in {
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = [
          myPython
          # LaTeX
          pkgs.texlive.combined.scheme-full
          pkgs.texlab
        ];
      };
    };
}

