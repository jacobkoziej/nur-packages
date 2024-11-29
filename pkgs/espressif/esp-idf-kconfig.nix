{
  lib,
  stdenv,
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonPackage rec {
  pname = "esp-idf-kconfig";
  version = "2.3.0";
  pyproject = true;

  disabled = python3Packages.pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "espressif";
    repo = "esp-idf-kconfig";
    rev = "refs/tags/v${version}";
    hash = "sha256-aZUSl4Q++GTxnS7/V+p1rcpdGbTAMLXBvUJ3Cmb5DJg=";
  };

  build-system = with python3Packages; [ setuptools ];

  propagatedBuildInputs = lib.optional stdenv.hostPlatform.isWindows (
    with python3Packages;
    [
      windows-curses
    ]
  );

  pythonImportsCheck = [
    "esp_idf_kconfig"
    "kconfcheck"
    "kconfgen"
    "kconfserver"
    "menuconfig"
  ];

  meta = with lib; {
    description = "Responsible for enabling project configuration using the kconfig language";
    homepage = "https://github.com/espressif/esp-idf-kconfig";
    changelog = "https://github.com/espressif/esp-idf-kconfig/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [
      jacobkoziej
    ];
  };
}
