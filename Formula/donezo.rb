class Donezo < Formula
  desc "Simple TUI to-do app written in Go using Bubble Tea and SQLite"
  homepage "https://github.com/rhajizada/donezo"
  url "https://github.com/rhajizada/donezo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4c52bb43338ef98d074437c60dd91e5d633bb627d6bf4a044dc1689dfbcc5430"
  license "MIT"
  head "https://github.com/rhajizada/donezo.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    system "make", "build"
    bin.install "bin/donezo"
  end

  test do
    assert_match "donezo #{version}", shell_output("#{bin}/donezo --version")
  end
end
