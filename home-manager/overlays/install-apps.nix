self: super: {

  installApplication =
    { name
    , appname ? name
    , version
    , src
    , description
    , homepage
    , postInstall ? ""
    , sourceRoot ? "."
    , ...
    }:
      with super; stdenv.mkDerivation {
        name = "${name}-${version}";
        version = "${version}";
        src = src;
        buildInputs = [ undmg unzip ];
        sourceRoot = sourceRoot;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p "$out/Applications/${appname}.app"
          cp -pR * "$out/Applications/${appname}.app"
        '' + postInstall;
        meta = with lib; {
          description = description;
          homepage = homepage;
          platforms = platforms.darwin;
        };
      };

  Rectangle = self.installApplication rec {
    name = "Rectangle";
    version = "0.49";
    sourceRoot = "Rectangle.app";
    src = super.fetchurl {
      url = https://github.com/rxhanson/Rectangle/releases/download/v0.49/Rectangle0.49.dmg;
      sha256 = "12ck00pvcbl1x7cyfwzdghjn538bhi1272k663dhxph02x7rlsb0";
    };
    description = "Rectangle";
    homepage = https://rectangleapp.com;
  };

}
