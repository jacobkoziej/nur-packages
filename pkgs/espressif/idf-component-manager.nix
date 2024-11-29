{
  lib,
  python3Packages,
  fetchFromGitHub,
  git,
}:

python3Packages.buildPythonApplication rec {
  pname = "idf-component-manager";
  version = "2.0.4";
  pyproject = true;

  disabled = python3Packages.pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "espressif";
    repo = "idf-component-manager";
    rev = "refs/tags/v${version}";
    hash = "sha256-ziy7/JGWnNx1W7kETvXugLTpF+srbNL/s8PWeKSCWcE=";
  };

  preBuild = ''
    export HOME=$(mktemp -d)
  '';

  build-system = with python3Packages; [ setuptools ];

  propagatedBuildInputs =
    (with python3Packages; [
      click
      colorama
      jsonref
      pydantic
      pydantic-core
      pydantic-settings
      pyparsing
      pyyaml
      requests
      requests-file
      requests-toolbelt
      ruamel-yaml
      tqdm
      typing-extensions
    ])
    ++ [
      git
    ];

  nativeCheckInputs =
    (with python3Packages; [
      jinja2
      jsonschema
      pexpect
      pytest
      pytest-cov
      pytest-mock
      pytestCheckHook
      requests-mock
      vcrpy
    ])
    ++ [
      git
    ];

  disabledTestPaths = [
    # rely on unavailable functionality
    "tests/cli/test_compote.py"
    "tests/test_prepare_dep_dirs.py"
    "tests/test_profile.py"
  ];

  pythonImportsCheck = [
    "idf_component_manager"
    "idf_component_tools"
  ];

  meta = with lib; {
    description = "Espressif IDF Component Manager";
    homepage = "https://github.com/espressif/idf-component-manager";
    changelog = "https://github.com/espressif/idf-component-manager/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [
      jacobkoziej
    ];
  };
}
