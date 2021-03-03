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

  Alfred = self.installApplication rec {
    name = "Alfred";
    version = "4.3.2";
    sourceRoot = "Alfred 4.app";
    src = super.fetchurl {
      url = https://cachefly.alfredapp.com/Alfred_4.3.2_1221.dmg;
      sha256 = "0zlnzrzg3kxxvh6nr7nyhcfk84k5xqnwrm3v6595mydg084f0rai";
    };
    description = "Alfred";
    homepage = https://alfredapp.com;
  };

  Rectangle = self.installApplication rec {
    name = "Rectangle";
    version = "0.43";
    sourceRoot = "Rectangle.app";
    src = super.fetchurl {
      url = https://github.com/rxhanson/Rectangle/releases/download/v0.43/Rectangle0.43.dmg;
      sha256 = "020sf87xxgxzv6a935q3fj67hldk0c1i9iycx9bl9spf44ijjcmc";
    };
    description = "Rectangle";
    homepage = https://rectangleapp.com;
  };
}
