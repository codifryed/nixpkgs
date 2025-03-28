{
  src,
  meta,
  version,
  stdenv,
  nodejs,
  pnpm_9,
}:

stdenv.mkDerivation (finalAttrs: {
  inherit version src meta;
  pname = "overlayed-webui";

  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs) src pname version;
    hash = "sha256-+yyxoodcDfqJ2pkosd6sMk77/71RDsGthedo1Oigwto=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm_9.configHook
  ];

  buildPhase = ''
    runHook preBuild

    cd apps/desktop
    node --max_old_space_size=1024000 ./node_modules/vite/bin/vite.js build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r dist $out

    runHook postInstall
  '';
})
