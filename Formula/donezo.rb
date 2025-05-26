class Donezo < Formula
  desc "Simple TUI to-do app in written Go using Bubble Tea and SQLite"
  homepage "https://github.com/rhajizada/donezo"
  license "MIT"
  version "0.1.0"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/rhajizada/donezo/releases/download/v0.1.0/donezo-darwin-amd64.tar.gz"
      sha256 "7343b970c05bde06b984c73d48e30b972a9d930ec1fe43584abe88c9dacdecde"
    else
      url "https://github.com/rhajizada/donezo/releases/download/v0.1.0/donezo-darwin-arm64.tar.gz"
      sha256 "0b8d26077994da39389a7c1491d0b3a011e3469c078cb32d6ff99a26f82a9869"
    end
  elsif OS.linux?
    url "https://github.com/rhajizada/donezo/releases/download/v0.1.0/donezo-linux-amd64.tar.gz"
    sha256 "65ffd54223d07f75105be054aac44c745c9abd098525904230862fbc84c86c30"
  end

  def install
    bin.install "donezo"
  end

  test do
    output = shell_output("#{bin}/donezo --version")
    assert_match "donezo #{version}", output
  end
end
