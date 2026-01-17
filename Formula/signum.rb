class Signum < Formula
  desc "SVG badge generator written in Go"
  homepage "https://github.com/rhajizada/signum"
  url "https://github.com/rhajizada/signum/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "33161d6d4367a4f6ae8c96ffca2e136b532b9b60f1bf9565212c83c281852a36"
  license "MIT"
  head "https://github.com/rhajizada/signum.git", branch: "main"

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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/signum-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "36da72cb0f70e4fbdec693760d4f38c66c415c1ab3d495d2347683db75e57a1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4fb6092ca2492069ab712221e7c462ef57d4cee5d2b7b11628f99fcbb8e16906"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/signum --version")
  end
end
