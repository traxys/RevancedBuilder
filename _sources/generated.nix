# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  revanced-cli = {
    pname = "revanced-cli";
    version = "2.9.3";
    src = fetchurl {
      url = "https://github.com/revanced/revanced-cli/releases/download/v2.9.3/revanced-cli-2.9.3-all.jar";
      sha256 = "sha256-aaSShWalQvLATloRFTNAIOfKPvTrZ1Kb/ihhCj8/6sw=";
    };
  };
  revanced-integrations = {
    pname = "revanced-integrations";
    version = "v0.36.4";
    src = fetchurl {
      url = "https://github.com/revanced/revanced-integrations/releases/download/v0.36.4/app-release-unsigned.apk";
      sha256 = "sha256-CXf9I1LVtVjy6mzayDzcdXGqGmA/mxV7WGjY+1/D14w=";
    };
  };
  revanced-patches = {
    pname = "revanced-patches";
    version = "2.44.0";
    src = fetchurl {
      url = "https://github.com/revanced/revanced-patches/releases/download/v2.44.0/revanced-patches-2.44.0.jar";
      sha256 = "sha256-aIhWxk/TT7KbX9ESGKFyY7nZ6rmtvu1YaB0ZL9q3Fxg=";
    };
  };
}