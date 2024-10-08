{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "crd2pulumi";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "pulumi";
    repo = "crd2pulumi";
    rev = "v${version}";
    sha256 = "sha256-DuTGsa8udtnYuWCqGZTXyELZsAse8EF2xiVcXl/SE3M=";
  };

  vendorHash = "sha256-pdrFG0vArpbPlXtgGulTLBvWttVps6vVZFn67tay2Gg=";

  ldflags = [ "-s" "-w" "-X github.com/pulumi/crd2pulumi/gen.Version=${src.rev}" ];

  subPackages = [ "." ];

  meta = with lib; {
    description = "Generate typed CustomResources from a Kubernetes CustomResourceDefinition";
    mainProgram = "crd2pulumi";
    homepage = "https://github.com/pulumi/crd2pulumi";
    license = licenses.asl20;
    maintainers = with maintainers; [ flokli ];
  };
}
