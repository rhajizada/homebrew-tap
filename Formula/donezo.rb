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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/donezo-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fa5a77d900a6be9fc373cb44a45f04e2960492b1f046b56bf586e60ef0f7a423"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8e3694241b943f877d2aea0974f9402454bdbb18ef1193dc90b7403914fadf94"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d17a00dda01ab1fae3a67d694806575d6ae9fb26f9a46b8ab335c2346ea62ee6"
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
