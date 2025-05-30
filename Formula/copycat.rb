class Copycat < Formula
  desc "CLI to copy project source code as Markdown to clipboard for LLMs"
  homepage "https://github.com/rhajizada/copycat"
  url "https://github.com/rhajizada/copycat/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "c1d2f92ba5828fb7f82767ae688d4f04aa9f3237a7da2acbd82069e069d9bb2b"
  license "MIT"
  head "https://github.com/rhajizada/copycat.git", branch: "main"

  livecheck do
    url     :stable
    regex(/^v(\d+\.\d+\.\d+)$/)

    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        match[1] if match
      end
    end
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "copycat #{version}", shell_output("#{bin}/copycat --version")
  end
end
