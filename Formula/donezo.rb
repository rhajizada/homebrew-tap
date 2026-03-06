class Donezo < Formula
  desc "Simple TUI to-do app written in Go using Bubble Tea and SQLite"
  homepage "https://github.com/rhajizada/donezo"
  url "https://github.com/rhajizada/donezo/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "37fda0fa19cbfa9df7535bf371d620fc66992fc4f42a38e7b5585674ce655f02"
  license "MIT"
  head "https://github.com/rhajizada/donezo.git", branch: "main"

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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/donezo-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7f22627fc873d62c5f62f11b2e68d5517fc0748a20debcdd9d8347b5437b1996"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0f860c580f0af1cc0e6d02d717c28856f52cbf910ab6ed741d93e3fa8fd4ff3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8016c17267b941ae8a60613927abf52a27d81666424af5f3ddb78da7f3a8ef4c"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match "donezo #{version}", shell_output("#{bin}/donezo --version")
  end
end
