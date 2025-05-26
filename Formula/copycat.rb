class Copycat < Formula
  desc "CLI to copy project source code as Markdown to clipboard for LLMs"
  homepage "https://github.com/rhajizada/copycat"
  version "0.2.0"
  license "MIT"
  version_scheme 1

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-x86_64-apple-darwin.tar.gz"
      sha256 "5f41303343bbd9bd54d23df2118df86507605526d30034d276c7e135ddf88e46"
    else
      url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-aarch64-apple-darwin.tar.gz"
      sha256 "9e5bdce56fc6ef76595241529dba5dbd7de184d7724133dba1dc53c9c73f74d4"
    end
  else
    url "https://github.com/rhajizada/copycat/releases/download/v#{version}/copycat-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "75a21808868c985534b3bd1f5af3495e15a15173c7fc966a8d3b3b5076985025"
  end

  def install
    bin.install "copycat"
  end

  test do
    output = shell_output("#{bin}/copycat --version")
    assert_match "copycat #{version}", output
  end
end
