# flake.nix
#
# This file packages licdata-artifact as a Nix flake.
#
# Copyright (C) 2024-today acm-sl's licdata-artifact
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
{
  description = "Nix flake for licdata-artifact";
  inputs = rec {
    nixos.url = "github:NixOS/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    pythoneda-shared-pythonlang-banner = {
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
      url = "github:pythoneda-shared-pythonlang-def/banner/0.0.62";
    };
    pythoneda-shared-pythonlang-domain = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      url = "github:pythoneda-shared-pythonlang-def/domain/0.0.75";
    };
    pythoneda-shared-pythonlang-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      url = "github:pythoneda-shared-pythonlang-def/infrastructure/0.0.54";
    };
    pythoneda-shared-pythonlang-application = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      inputs.pythoneda-shared-pythonlang-infrastructure.follows =
        "pythoneda-shared-pythonlang-infrastructure";
      url = "github:pythoneda-shared-pythonlang-def/application/0.0.75";
    };
    pythoneda-shared-pythonlang-artf-domain = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      inputs.pythoneda-shared-pythonlang-infrastructure.follows =
        "pythoneda-shared-pythonlang-infrastructure";
      url = "github:pythoneda-shared-pythonlang-artf-def/domain/0.0.1";
    };
    pythoneda-shared-pythonlang-artf-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      inputs.pythoneda-shared-pythonlang-infrastructure.follows =
        "pythoneda-shared-pythonlang-infrastructure";
      inputs.pythoneda-shared-pythonlang-artf-domain.follows =
        "pythoneda-shared-pythonlang-artf-domain";
      url = "github:pythoneda-shared-pythonlang-artf-def/infrastructure/0.0.1";
    };
    pythoneda-shared-pythonlang-artf-application = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      inputs.pythoneda-shared-pythonlang-infrastructure.follows =
        "pythoneda-shared-pythonlang-infrastructure";
      inputs.pythoneda-shared-pythonlang-artf-domain.follows =
        "pythoneda-shared-pythonlang-artf-domain";
      inputs.pythoneda-shared-pythonlang-artf-infrastructure.follows =
        "pythoneda-shared-pythonlang-artf-infrastructure";
      url = "github:pythoneda-shared-pythonlang-artf-def/application/0.0.1";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "acmsl";
        repo = "licdata-artifact";
        version = "0.0.1";
        sha256 = "025wi8c6s039ach03a19y9rqa62rzf95kix87nhh68r8p959wkbm";
        pname = "${org}-${repo}";
        pythonpackage = "org.acmsl.licdata";
        package = builtins.replaceStrings [ "." ] [ "/" ] pythonpackage;
        pkgs = import nixos { inherit system; };
        description = "Licdata Artifact";
        entrypoint = "licdata_artifact_app";
        license = pkgs.lib.licenses.gpl3;
        homepage = "https://github.com/${org}/${repo}";
        maintainers = [ "rydnr <github@acm-sl.org>" ];
        archRole = "B";
        space = "A";
        layer = "D";
        nixosVersion = builtins.readFile "${nixos}/.version";
        nixpkgsRelease =
          builtins.replaceStrings [ "\n" ] [ "" ] "nixos-${nixosVersion}";
        shared = import "${pythoneda-shared-pythonlang-banner}/nix/shared.nix";
        licdata-for = { azure-functions, python
          , pythoneda-shared-pythonlang-banner
          , pythoneda-shared-pythonlang-domain
          , pythoneda-shared-pythonlang-infrastructure
          , pythoneda-shared-pythonlang-application
          , pythoneda-shared-pythonlang-artf-domain
          , pythoneda-shared-pythonlang-artf-infrastructure
          , pythoneda-shared-pythonlang-artf-application}:
          let
            pnameWithUnderscores =
              builtins.replaceStrings [ "-" ] [ "_" ] pname;
            pythonVersionParts = builtins.splitVersion python.version;
            pythonMajorVersion = builtins.head pythonVersionParts;
            pythonMajorMinorVersion =
              "${pythonMajorVersion}.${builtins.elemAt pythonVersionParts 1}";
            wheelName =
              "${pnameWithUnderscores}-${version}-py${pythonMajorVersion}-none-any.whl";
            banner_file = "${package}/licdata_banner.py";
            banner_class = "LicdataBanner";
          in python.pkgs.buildPythonPackage rec {
            inherit pname version;
            projectDir = ./.;
            pyprojectTomlTemplate = ./templates/pyproject.toml.template;
            pyprojectToml = pkgs.substituteAll {
              authors = builtins.concatStringsSep ","
                (map (item: ''"${item}"'') maintainers);
              azureFunctions = azure-functions.version;
              cryptography = python.pkgs.cryptography.version;
              desc = description;
              # emails = python.pkgs.emails.version;
              inherit homepage pname pythonMajorMinorVersion pythonpackage
                version;
              package = builtins.replaceStrings [ "." ] [ "/" ] pythonpackage;
              pygithub = python.pkgs.pygithub.version;
              pythonedaSharedPythonlangBanner =
                pythoneda-shared-pythonlang-banner.version;
              pythonedaSharedPythonlangDomain =
                pythoneda-shared-pythonlang-domain.version;
              pythonedaSharedPythonlangInfrastructure =
                pythoneda-shared-pythonlang-infrastructure.version;
              pythonedaSharedPythonlangApplication =
                pythoneda-shared-pythonlang-application.version;
              pythonedaSharedPythonlangArtfDomain =
                pythoneda-shared-pythonlang-artf-domain.version;
              pythonedaSharedPythonlangArtfInfrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.version;
              pythonedaSharedPythonlangArtfApplication =
                pythoneda-shared-pythonlang-artf-application.version;
              src = pyprojectTomlTemplate;
            };
            bannerTemplateFile = ./templates/banner.py.template;
            bannerTemplate = pkgs.substituteAll {
              project_name = pname;
              file_path = banner_file;
              inherit banner_class org repo;
              tag = version;
              pescio_space = space;
              arch_role = archRole;
              hexagonal_layer = layer;
              python_version = pythonMajorMinorVersion;
              nixpkgs_release = nixpkgsRelease;
              src = bannerTemplateFile;
            };

            entrypointTemplateFile =
              "${pythoneda-shared-pythonlang-banner}/templates/entrypoint.sh.template";
            entrypointTemplate = pkgs.substituteAll {
              arch_role = archRole;
              hexagonal_layer = layer;
              nixpkgs_release = nixpkgsRelease;
              inherit homepage maintainers org python repo version;
              pescio_space = space;
              python_version = pythonMajorMinorVersion;
              pythoneda_shared_pythoneda_banner =
                pythoneda-shared-pythonlang-banner;
              pythoneda_shared_pythoneda_domain =
                pythoneda-shared-pythonlang-domain;
              src = entrypointTemplateFile;
            };
            src = pkgs.fetchFromGitHub {
              owner = org;
              rev = version;
              inherit repo sha256;
            };

            format = "pyproject";

            nativeBuildInputs = with python.pkgs; [ pip poetry-core ];
            propagatedBuildInputs = with python.pkgs; [
              pythoneda-shared-pythonlang-banner
              pythoneda-shared-pythonlang-domain
              pythoneda-shared-pythonlang-infrastructure
              pythoneda-shared-pythonlang-application
              pythoneda-shared-pythonlang-artf-domain
              pythoneda-shared-pythonlang-artf-infrastructure
              pythoneda-shared-pythonlang-artf-application
            ];

            # pythonImportsCheck = [ pythonpackage ];

            unpackPhase = ''
              cp -r ${src}/rest .
              sourceRoot=$(ls | grep -v env-vars)
              chmod +w $sourceRoot
              find $sourceRoot -type d -exec chmod 777 {} \;
              cp ${pyprojectToml} $sourceRoot/pyproject.toml
              cp ${bannerTemplate} $sourceRoot/${banner_file}
              cp ${entrypointTemplate} $sourceRoot/entrypoint.sh
              pushd $sourceRoot
            '';

            postPatch = ''
              substituteInPlace /build/$sourceRoot/entrypoint.sh \
                --replace "@SOURCE@" "$out/bin/${entrypoint}.sh" \
                --replace "@PYTHONEDA_EXTRA_NAMESPACES@" "org" \
                --replace "@PYTHONPATH@" "$PYTHONPATH" \
                --replace "@CUSTOM_CONTENT@" "" \
                --replace "@PYTHONEDA_SHARED_PYTHONLANG_DOMAIN@" "${pythoneda-shared-pythonlang-domain}" \
                --replace "@PACKAGE@" "$out/lib/python${pythonMajorMinorVersion}/site-packages" \
                --replace "@ENTRYPOINT@" "$out/lib/python${pythonMajorMinorVersion}/site-packages/${package}/application/${entrypoint}.py" \
                --replace "@BANNER@" "$out/bin/banner.sh"
            '';

            postInstall = ''
              command pushd /build/$sourceRoot
              for f in $(command find . -name '__init__.py' | grep -v '.deps' | sed 's ^\./  g'); do
                if [[ ! -e $out/lib/python${pythonMajorMinorVersion}/site-packages/$f ]]; then
                  command mkdir -p $out/lib/python${pythonMajorMinorVersion}/site-packages/"$(command dirname $f)";
                  command cp -r "$(command dirname $f)"/* $out/lib/python${pythonMajorMinorVersion}/site-packages/"$(command dirname $f)";
                fi
              done
              command popd
              command mkdir $out/dist $out/bin
              command cp dist/${wheelName} /build/$sourceRoot/rest.zip /build/$sourceRoot/requirements.txt /build/$sourceRoot/Dockerfile $out/dist
              command cp /build/$sourceRoot/entrypoint.sh $out/bin/${entrypoint}.sh
              command chmod +x $out/bin/${entrypoint}.sh
              command echo '#!/usr/bin/env sh' > $out/bin/banner.sh
              command echo "export PYTHONPATH=$PYTHONPATH" >> $out/bin/banner.sh
              command echo "command echo 'Running $out/bin/banner'" >> $out/bin/banner.sh
              command echo "${python}/bin/python $out/lib/python${pythonMajorMinorVersion}/site-packages/${banner_file} \$@" >> $out/bin/banner.sh
              command chmod +x $out/bin/banner.sh
            '';

            meta = with pkgs.lib; {
              inherit description homepage license maintainers;
            };
          };
      in rec {
        apps = rec {
          default = licdata-default;
          licdata-default = licdata-python312;
          licdata-python38 = shared.app-for {
            package =
              self.packages.${system}.licdata-python38;
            inherit entrypoint;
          };
          licdata-python39 = shared.app-for {
            package =
              self.packages.${system}.licdata-python39;
            inherit entrypoint;
          };
          licdata-python310 = shared.app-for {
            package =
              self.packages.${system}.licdata-python310;
            inherit entrypoint;
          };
          licdata-python311 = shared.app-for {
            package =
              self.packages.${system}.licdata-python311;
            inherit entrypoint;
          };
          licdata-python312 = shared.app-for {
            package =
              self.packages.${system}.licdata-python312;
            inherit entrypoint;
          };
        };
        defaultApp = apps.default;
        defaultPackage = packages.default;
        devShells = rec {
          default = licdata-default;
          licdata-default = licdata-python312;
          licdata-python38 =
            shared.devShell-for {
              banner = "${packages.licdata-python38}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package = packages.licdata-python38;
              python = pkgs.python38;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python38;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python38;
              inherit archRole layer org pkgs repo space;
            };
          licdata-python39 =
            shared.devShell-for {
              banner = "${packages.licdata-python39}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-python39;
              python = pkgs.python39;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python39;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python39;
              inherit archRole layer org pkgs repo space;
            };
          licdata-python310 =
            shared.devShell-for {
              banner = "${packages.licdata-python310}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-python310;
              python = pkgs.python310;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python310;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python310;
              inherit archRole layer org pkgs repo space;
            };
          licdata-python311 =
            shared.devShell-for {
              banner = "${packages.licdata-python311}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-python311;
              python = pkgs.python311;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python311;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python311;
              inherit archRole layer org pkgs repo space;
            };
          licdata-python312 =
            shared.devShell-for {
              banner = "${packages.licdata-python312}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-python312;
              python = pkgs.python312;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python312;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python312;
              inherit archRole layer org pkgs repo space;
            };
        };
        packages = rec {
          default = licdata-python312;
          licdata-python38 =
            pythoneda-licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python38;
              python = pkgs.python38;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python38;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python38;
              pythoneda-shared-pythonlang-infrastructure =
                pythoneda-shared-pythonlang-infrastructure.packages.${system}.pythoneda-shared-pythonlang-infrastructure-python38;
              pythoneda-shared-pythonlang-application =
                pythoneda-shared-pythonlang-application.packages.${system}.pythoneda-shared-pythonlang-application-python38;
              pythoneda-shared-pythonlang-artf-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python38;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python38;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python38;
            };
          licdata-python39 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python39;
              python = pkgs.python39;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python39;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python39;
              pythoneda-shared-pythonlang-infrastructure =
                pythoneda-shared-pythonlang-infrastructure.packages.${system}.pythoneda-shared-pythonlang-infrastructure-python39;
              pythoneda-shared-pythonlang-application =
                pythoneda-shared-pythonlang-application.packages.${system}.pythoneda-shared-pythonlang-application-python39;
              pythoneda-shared-pythonlang-artf-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python39;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python39;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python39;
            };
          licdata-python310 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python310;
              python = pkgs.python310;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python310;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python310;
              pythoneda-shared-pythonlang-infrastructure =
                pythoneda-shared-pythonlang-infrastructure.packages.${system}.pythoneda-shared-pythonlang-infrastructure-python310;
              pythoneda-shared-pythonlang-application =
                pythoneda-shared-pythonlang-application.packages.${system}.pythoneda-shared-pythonlang-application-python310;
              pythoneda-shared-pythonlang-artf-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python310;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python310;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python310;
            };
          licdata-python311 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python311;
              python = pkgs.python311;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python311;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python311;
              pythoneda-shared-pythonlang-infrastructure =
                pythoneda-shared-pythonlang-infrastructure.packages.${system}.pythoneda-shared-pythonlang-infrastructure-python311;
              pythoneda-shared-pythonlang-application =
                pythoneda-shared-pythonlang-application.packages.${system}.pythoneda-shared-pythonlang-application-python311;
              pythoneda-shared-pythonlang-artf-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python311;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python311;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python311;
            };
          licdata-python312 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python312;
              python = pkgs.python312;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python312;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python312;
              pythoneda-shared-pythonlang-infrastructure =
                pythoneda-shared-pythonlang-infrastructure.packages.${system}.pythoneda-shared-pythonlang-infrastructure-python312;
              pythoneda-shared-pythonlang-application =
                pythoneda-shared-pythonlang-application.packages.${system}.pythoneda-shared-pythonlang-application-python312;
              pythoneda-shared-pythonlang-artf-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python312;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python312;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python312;
            };
        };
      });
}
