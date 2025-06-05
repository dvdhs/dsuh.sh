let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.stdenv.mkDerivation {
  name = "dsuh.sh";
  src = ./.;
  
  buildInputs = with pkgs; [
    pandoc
    rsync
    sass
    gnum4
    python313
    fswatch
  ];
  
  buildPhase = ''
  make clean && make -j CC=clang
  '';

  installPhase = ''
    mkdir -p $out
    cp -r o $out 
  '';
}
