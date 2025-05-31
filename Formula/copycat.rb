class Copycat < Formula
  desc "CLI to copy project source code as Markdown to clipboard for LLMs"
  homepage "https://github.com/rhajizada/copycat"
  url "https://github.com/rhajizada/copycat/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "c1d2f92ba5828fb7f82767ae688d4f04aa9f3237a7da2acbd82069e069d9bb2b"
  license "MIT"
  head "https://github.com/rhajizada/copycat.git", branch: "main"

  livecheck do
    url     :stable
    regex(/^v(\d+\.\d+\.\d+)$/i)

    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        match[1] if match
      end
    end
  end

  bottle do
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/copycat-0.2.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "655892a1119bef2c0c72b7683f0ad5846d4a2a3d04822fcdeac64fc26b98cdd2"
    sha256 cellar: :any_skip_relocation, ventura:       "ee5242823315c5b36c9c95de299a222de41049d65b3bc284e684b2e8923cd7f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1de780c666b74e789027bd162d1c5b3ad2f7c8afa6a4ab9c6f68329b1753dcab"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "copycat #{version}", shell_output("#{bin}/copycat --version")
  end
end
