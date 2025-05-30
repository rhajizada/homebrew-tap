class Copycat < Formula
  desc "CLI to copy project source code as Markdown to clipboard for LLMs"
  homepage "https://github.com/rhajizada/copycat"
  version "0.2.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-x86_64-apple-darwin.tar.gz"
    sha256 "91eb679d0ab2b888109d277812ca6a63bb79c2cdc0467b35afdf211626fa95ca"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-aarch64-apple-darwin.tar.gz"
    sha256 "6af79e8cd7d0fa4fc63c706cafa6a3d4bee0b1537eb0898c43599e9f884d562e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "75a21808868c985534b3bd1f5af3495e15a15173c7fc966a8d3b3b5076985025"
  end

  def install
    bin.install "copycat"
  end

  test do
    assert_match "copycat #{version}", shell_output("#{bin}/copycat --version")
  end
end
