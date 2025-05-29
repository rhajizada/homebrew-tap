class Copycat < Formula
  desc "CLI to copy project source code as Markdown to clipboard for LLMs"
  homepage "https://github.com/rhajizada/copycat"
  version "0.2.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-x86_64-apple-darwin.tar.gz"
    sha256 "e9c9ecffefb701d7f582b08222b53fbef6838ccfe099d05fe989545e966097ec"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-aarch64-apple-darwin.tar.gz"
    sha256 "2b690914a1bbb68a98183a710ba2311d2f2f3ff3be4b0fece4a38259b3d59bd5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a74efa364c318fb980f7c70c79cf196d55f529dc3ac363337949d43e53da83b0"
  end

  def install
    bin.install "copycat"
  end

  test do
    assert_match "copycat #{version}", shell_output("#{bin}/copycat --version")
  end
end
