{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonPackage rec {
  pname = "esp-idf-panic-decoder";
  version = "1.2.1";
  pyproject = true;

  disabled = python3Packages.pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "espressif";
    repo = "esp-idf-panic-decoder";
    rev = "refs/tags/v${version}";
    hash = "sha256-YhkPnLWgYLMnh4a6RRMcWlK1NNotrnj/zI9p8CNy6r0=";
  };

  build-system = with python3Packages; [ setuptools ];

  propagatedBuildInputs = with python3Packages; [
    pyelftools
  ];

  pythonImportsCheck = [
    "esp_idf_panic_decoder"
  ];

  meta = with lib; {
    description = "A script that parses ESP-IDF panic handler output";
    homepage = "https://github.com/espressif/esp-panic-decoder-kconfig";
    changelog = "https://github.com/espressif/esp-panic-decoder-kconfig/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [
      jacobkoziej
    ];
  };
}
