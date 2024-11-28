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
  description = "Nix flake for acmsl/licdata-artifact";
  inputs = rec {
    acmsl-licdata-artifact-events = {
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      url = "github:acmsl-def/licdata-artifact-events/0.0.7";
    };
    acmsl-licdata-artifact-events-infrastructure = {
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
      inputs.acmsl-licdata-artifact-events.follows = "acmsl-licdata-artifact-events";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      url = "github:acmsl-def/licdata-artifact-events-infrastructure/0.0.7";
    };
    azure-functions = {
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
      url = "github:rydnr/nix-flakes/azure-functions-1.21.3.0?dir=azure-functions";
    };
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    nixos.url = "github:NixOS/nixpkgs/24.05";
    pythoneda-shared-pythonlang-banner = {
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
      url = "github:pythoneda-shared-pythonlang-def/banner/0.0.70";
    };
    pythoneda-shared-pythonlang-domain = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      url = "github:pythoneda-shared-pythonlang-def/domain/0.0.88";
    };
    pythoneda-shared-pythonlang-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      url = "github:pythoneda-shared-pythonlang-def/infrastructure/0.0.64";
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
      url = "github:pythoneda-shared-pythonlang-def/application/0.0.85";
    };
    pythoneda-shared-pythonlang-artf-domain = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      url = "github:pythoneda-shared-pythonlang-artf-def/domain/0.0.64";
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
      url = "github:pythoneda-shared-pythonlang-artf-def/infrastructure/0.0.56";
    };
    pythoneda-shared-pythonlang-artf-application = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythonlang-banner.follows =
        "pythoneda-shared-pythonlang-banner";
      inputs.pythoneda-shared-pythonlang-domain.follows =
        "pythoneda-shared-pythonlang-domain";
      url = "github:pythoneda-shared-pythonlang-artf-def/application/0.0.39";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "acmsl";
        repo = "licdata-artifact";
        version = "0.0.6";
        sha256 = "1kp68l3m6ppq7nr5v9vx7vgchabr6jcn57lvz9cylw0grc2g9k21";
        pname = "${org}-${repo}";
        pythonpackage = "org.acmsl.artifact.licdata";
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
        licdata-for = { azure-functions, acmsl-licdata-artifact-events, acmsl-licdata-artifact-events-infrastructure, python
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
            banner_file = "${package}/application/licdata_artifact_banner.py";
            banner_class = "LicdataArtifactBanner";
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
              acmslLicdataArtifactEvents = acmsl-licdata-artifact-events.version;
              acmslLicdataArtifactEventsInfrastructure = acmsl-licdata-artifact-events-infrastructure.version;
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
              acmsl-licdata-artifact-events
              acmsl-licdata-artifact-events-infrastructure
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
              command cp -r ${src} .
              sourceRoot=$(ls | grep -v env-vars)
              command chmod -R +w $sourceRoot
              command cp ${pyprojectToml} $sourceRoot/pyproject.toml
              command cp ${bannerTemplate} $sourceRoot/${banner_file}
              command cp ${entrypointTemplate} $sourceRoot/entrypoint.sh
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
                --replace "@PYTHON_ARGS@" "" \
                --replace "@BANNER@" "$out/bin/banner.sh"
            '';

            postInstall = ''
              command pushd /build/$sourceRoot
              for f in $(command find . -name '__init__.py' | sed 's ^\./  g'); do
                if [[ ! -e $out/lib/python${pythonMajorMinorVersion}/site-packages/$f ]]; then
                  command mkdir -p $out/lib/python${pythonMajorMinorVersion}/site-packages/"$(command dirname $f)";
                  command cp -r "$(command dirname $f)"/* $out/lib/python${pythonMajorMinorVersion}/site-packages/"$(command dirname $f)";
                fi
              done
              command popd
              command mkdir $out/dist $out/bin
              command cp dist/${wheelName} $out/dist
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
          licdata-default = licdata-artifact-python312;
          licdata-artifact-python38 = shared.app-for {
            package =
              self.packages.${system}.licdata-artifact-python38;
            inherit entrypoint;
          };
          licdata-artifact-python39 = shared.app-for {
            package =
              self.packages.${system}.licdata-artifact-python39;
            inherit entrypoint;
          };
          licdata-artifact-python310 = shared.app-for {
            package =
              self.packages.${system}.licdata-artifact-python310;
            inherit entrypoint;
          };
          licdata-artifact-python311 = shared.app-for {
            package =
              self.packages.${system}.licdata-artifact-python311;
            inherit entrypoint;
          };
          licdata-artifact-python312 = shared.app-for {
            package =
              self.packages.${system}.licdata-artifact-python312;
            inherit entrypoint;
          };
        };
        defaultApp = apps.default;
        defaultPackage = packages.default;
        devShells = rec {
          default = licdata-artifact-python312;
          licdata-artifact-python38 =
            shared.devShell-for {
              banner = "${packages.licdata-artifact-python38}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package = packages.licdata-artifact-python38;
              python = pkgs.python38;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python38;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python38;
              inherit archRole layer org pkgs repo space;
            };
          licdata-artifact-python39 =
            shared.devShell-for {
              banner = "${packages.licdata-artifact-python39}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-artifact-python39;
              python = pkgs.python39;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python39;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python39;
              inherit archRole layer org pkgs repo space;
            };
          licdata-artifact-python310 =
            shared.devShell-for {
              banner = "${packages.licdata-artifact-python310}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-artifact-python310;
              python = pkgs.python310;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python310;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python310;
              inherit archRole layer org pkgs repo space;
            };
          licdata-artifact-python311 =
            shared.devShell-for {
              banner = "${packages.licdata-artifact-python311}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-artifact-python311;
              python = pkgs.python311;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python311;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python311;
              inherit archRole layer org pkgs repo space;
            };
          licdata-artifact-python312 =
            shared.devShell-for {
              banner = "${packages.licdata-artifact-python312}/bin/banner.sh";
              extra-namespaces = "org";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.licdata-artifact-python312;
              python = pkgs.python312;
              pythoneda-shared-pythonlang-banner =
                pythoneda-shared-pythonlang-banner.packages.${system}.pythoneda-shared-pythonlang-banner-python312;
              pythoneda-shared-pythonlang-domain =
                pythoneda-shared-pythonlang-domain.packages.${system}.pythoneda-shared-pythonlang-domain-python312;
              inherit archRole layer org pkgs repo space;
            };
        };
        packages = rec {
          default = licdata-artifact-python312;
          licdata-artifact-python38 =
            pythoneda-licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python38;
              acmsl-licdata-artifact-events =
                acmsl-licdata-artifact-events.packages.${system}.acmsl-licdata-artifact-events-python38;
              acmsl-licdata-artifact-events-infrastructure =
                acmsl-licdata-artifact-events-infrastructure.packages.${system}.acmsl-licdata-artifact-events-infrastructure-python38;
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
                pythoneda-shared-pythonlang-artf-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python38;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python38;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python38;
            };
          licdata-artifact-python39 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python39;
              acmsl-licdata-artifact-events =
                acmsl-licdata-artifact-events.packages.${system}.acmsl-licdata-artifact-events-python39;
              acmsl-licdata-artifact-events-infrastructure =
                acmsl-licdata-artifact-events-infrastructure.packages.${system}.acmsl-licdata-artifact-events-infrastructure-python39;
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
                pythoneda-shared-pythonlang-artf-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python39;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python39;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python39;
            };
          licdata-artifact-python310 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python310;
              acmsl-licdata-artifact-events =
                acmsl-licdata-artifact-events.packages.${system}.acmsl-licdata-artifact-events-python310;
              acmsl-licdata-artifact-events-infrastructure =
                acmsl-licdata-artifact-events-infrastructure.packages.${system}.acmsl-licdata-artifact-events-infrastructure-python310;
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
                pythoneda-shared-pythonlang-artf-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python310;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python310;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python310;
            };
          licdata-artifact-python311 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python311;
              acmsl-licdata-artifact-events =
                acmsl-licdata-artifact-events.packages.${system}.acmsl-licdata-artifact-events-python311;
              acmsl-licdata-artifact-events-infrastructure =
                acmsl-licdata-artifact-events-infrastructure.packages.${system}.acmsl-licdata-artifact-events-infrastructure-python311;
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
                pythoneda-shared-pythonlang-artf-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python311;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python311;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python311;
            };
          licdata-artifact-python312 =
            licdata-for {
              azure-functions =
                azure-functions.packages.${system}.azure-functions-python312;
              acmsl-licdata-artifact-events =
                acmsl-licdata-artifact-events.packages.${system}.acmsl-licdata-artifact-events-python312;
              acmsl-licdata-artifact-events-infrastructure =
                acmsl-licdata-artifact-events-infrastructure.packages.${system}.acmsl-licdata-artifact-events-infrastructure-python312;
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
                pythoneda-shared-pythonlang-artf-domain.packages.${system}.pythoneda-shared-pythonlang-artf-domain-python312;
              pythoneda-shared-pythonlang-artf-infrastructure =
                pythoneda-shared-pythonlang-artf-infrastructure.packages.${system}.pythoneda-shared-pythonlang-artf-infrastructure-python312;
              pythoneda-shared-pythonlang-artf-application =
                pythoneda-shared-pythonlang-artf-application.packages.${system}.pythoneda-shared-pythonlang-artf-application-python312;
            };
        };
      });
}
