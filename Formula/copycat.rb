class Copycat < Formula
  desc "CLI to copy project source code as Markdown to clipboard for LLMs"
  homepage "https://github.com/rhajizada/copycat"
  url "https://github.com/rhajizada/copycat/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "c1d2f92ba5828fb7f82767ae688d4f04aa9f3237a7da2acbd82069e069d9bb2b"
  license "MIT"
  head "https://github.com/rhajizada/copycat.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "copycat #{version}", shell_output("#{bin}/copycat --version")
  end
end
