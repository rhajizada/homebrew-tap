class Donezo < Formula
  desc "Simple TUI to-do app written in Go using Bubble Tea and SQLite"
  homepage "https://github.com/rhajizada/donezo"
  url "https://github.com/rhajizada/donezo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4c52bb43338ef98d074437c60dd91e5d633bb627d6bf4a044dc1689dfbcc5430"
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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/donezo-0.1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "41ad303ea1b0ae12a144292ac7eb0eabf1cddd9fadc54418bafd0c3d46026a3d"
    sha256 cellar: :any_skip_relocation, ventura:       "dd2cbe8f052913f4e2d647106b9119105bf5f9b3030a09f0ce6a1ae0f98d35a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "378ae7c96365b6d119af4d86225bb656bf0298d3f3a2c77b0b28be7eb5781d3a"
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
