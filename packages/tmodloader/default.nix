{ lib
, stdenv
, fetchurl
, pkgs
, autoPatchelfHook
, unzip
, zlib
}:

stdenv.mkDerivation rec {
  pname = "tmodloader-server";
  version = "1.4.4.9";
  urlVersion = lib.replaceStrings [ "." ] [ "" ] version;

  src = fetchurl {
    url = "https://github.com/tModLoader/tModLoader/releases/download/v2024.08.3.1/tModLoader.zip";
    sha256 = "sha256-DaBjLdlyVBiRSoPqGB7ugtHHe2vo7X8OfL71nLnhhig=";
  };

  dotnetPkg = (with pkgs.dotnetCorePackages; combinePackages [ sdk_8_0 ]);

  deps = with pkgs; [
    pkg-config
    zlib
    zlib.dev
    icu
    icu.dev
    openssl
    dotnetPkg
    patchelf
    glib
    gtk3
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ] ++ deps;

  NIX_LD = "${pkgs.stdenv.cc.libc_bin}/bin/ld.so";
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath ([
    stdenv.cc.cc
  ] ++ deps);

  buildInputs = [ stdenv.cc.cc.libgcc zlib ];
  unpackPhase = ''
    unzip ${src} -d $out
  '';
  DOTNET_ROOT = "${dotnetPkg}";


  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    chmod +x $out/*.sh
    chmod +x $out/LaunchUtils/*.sh
    mkdir $out/tModLoader-Logs
    touch $out/tModLoader-Logs/Lanch.log
    chmod +rw $out/tModLoader-Logs/Lanch.log
    touch $out/tModLoader-Logs/Native.log
    chmod +rw $out/tModLoader-Logs/Native.log
    sh $out/LaunchUtils/InstallDotNet.sh
    echo "${dotnetPkg}/bin/dotnet $out/tModLoader.dll -server" > $out/run.sh
    chmod +x $out/run.sh
    ln -s $out/run.sh $out/bin/tmodloader-server
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.tmodloader.net/";
    description = "tmodloader-server";
    platforms = [ "x86_64-linux" ];
    license = licenses.unfree;
    mainProgram = "TerrariaServer";
  };
}
