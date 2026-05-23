{
  description = "Adithya Venkatesh's resume";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tex = pkgs.texliveSmall.withPackages (ps: [
            ps.xetex
            ps.fontspec
            ps.xltxtra
            ps.xunicode
            ps.realscripts
            ps.metalogo
            ps.marvosym
            ps.xcolor
            ps.geometry
            ps.fancyhdr
            ps.hyperref
            ps.graphics
            ps.tools
            ps.tipa
            ps.greek-fontenc
          ]);
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "cv";
            version = "0.1.0";
            src = ./.;
            buildInputs = [ tex ];
            buildPhase = ''
              xelatex cv_3.tex
            '';
            installPhase = ''
              mkdir -p $out
              cp cv_3.pdf $out/
            '';
          };
        }
      );

      apps = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          cv = self.packages.${system}.default;
          script = pkgs.writeShellScript "build-resume" ''
            set -euo pipefail
            install -m 644 "${cv}/cv_3.pdf" resume.pdf
            echo "wrote resume.pdf"
          '';
        in
        {
          default = {
            type = "app";
            program = "${script}";
          };
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tex = pkgs.texliveSmall.withPackages (ps: [
            ps.xetex
            ps.fontspec
            ps.xltxtra
            ps.xunicode
            ps.realscripts
            ps.metalogo
            ps.marvosym
            ps.xcolor
            ps.geometry
            ps.fancyhdr
            ps.hyperref
            ps.graphics
            ps.tools
            ps.tipa
            ps.greek-fontenc
          ]);
        in
        {
          default = pkgs.mkShell {
            buildInputs = [ tex ];
          };
        }
      );
    };
}
