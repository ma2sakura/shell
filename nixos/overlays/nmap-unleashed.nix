final: prev: {
  nmap-unleashed = prev.python3Packages.buildPythonApplication rec {
    pname = "nmap-unleashed";
    version = "1.1.0";

    src = prev.fetchFromGitHub {
      owner = "sharkeonix";
      repo = "nmap-unleashed";
      rev = "main";
      hash = "sha256-UfoeO8PnC9XEafQ0QxSfA4gsWhrgfl8aWq7i2iAX9nA=";
    };

    pyproject = true;

    build-system = with prev.python3Packages; [
      setuptools
      wheel
    ];

    dependencies = with prev.python3Packages; [
      typer
      typing-extensions
      rich
      psutil
      prompt-toolkit
      json5
    ];

    nativeBuildInputs = [ prev.makeWrapper ];

    postInstall = ''
      wrapProgram $out/bin/nu \
        --prefix PATH : ${prev.lib.makeBinPath [ prev.nmap prev.libxslt prev.gnugrep ]}
    '';

    doCheck = false;

    meta = {
      description = "Nmap Unleashed - TUI for Nmap";
      homepage = "https://github.com/sharkeonix/nmap-unleashed";
      mainProgram = "nu";
    };
  };
}