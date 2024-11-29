{
  lib,
  python3Packages,
  fetchFromGitHub,
  esptool,
}:

python3Packages.buildPythonApplication rec {
  pname = "esp-coredump";
  version = "1.12.0";
  pyproject = true;

  disabled = python3Packages.pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "espressif";
    repo = "esp-coredump";
    rev = "refs/tags/v${version}";
    hash = "sha256-s4lUNTbwDROvZCO8piBc/7fRs6wVzzz7GUxU/Ia9ybg=";
  };

  build-system = with python3Packages; [ setuptools ];

  propagatedBuildInputs =
    (with python3Packages; [
      construct
      pygdbmi
    ])
    ++ [
      esptool
    ];

  pythonImportsCheck = [
    "esp_coredump"
  ];

  meta = with lib; {
    description = "Utility that helps users to retrieve and analyse core dumps";
    homepage = "https://github.com/espressif/esp-coredump";
    changelog = "https://github.com/espressif/esp-coredump/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [
      jacobkoziej
    ];
  };
}
