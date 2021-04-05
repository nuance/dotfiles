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

  Secretive = self.installApplication rec {
    name = "Secretive";
    version = "2.1.0";
    sourceRoot = "Secretive.app";
    src = super.fetchurl {
      url = https://github.com/maxgoedjen/secretive/releases/download/v2.1.0/Secretive.zip;
      sha256 = "15fw249r4yamczii8qs32fy48k5hnln1db4xfiflz7mcab2dh8ar";
    };
    description = "Secretive";
    homepage = https://github.com/maxgoedjen/secretive;
  };

  Itsycal = self.installApplication rec {
    name = "Itsycal";
    version = "0.12.6";
    sourceRoot = "Itsycal.app";
    src = super.fetchurl {
      url = https://itsycal.s3.amazonaws.com/Itsycal-0.12.6.zip;
      sha256 = "1dlzsfi9nwqmvvn54yn7yibzhnvj6jlyy7swp0kwqgc1cyfj37zz";
    };
    description = "Itsycal";
    homepage = https://www.mowglii.com/itsycal/;
  };

  XBar = self.installApplication rec {
    name = "xbar";
    version = "2.0.42";
    sourceRoot = "xbar.app";
    src = super.fetchurl {
      url = https://github.com/matryer/xbar/releases/download/v2.0.42-beta/xbar.v2.0.42-beta.dmg;
      sha256 = "0n9nngpywmn1iqv87m3gq7scnrwi6spb7g12qs74l4sfgldrqp0g";
    };
    description = "xbar";
    homepage = https://www.xbarapp.com;
  };
}
