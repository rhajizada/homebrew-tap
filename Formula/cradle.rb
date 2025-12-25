class Cradle < Formula
  desc "CLI to build and launch Docker images with a consistent, pre-configured setup"
  homepage "https://github.com/rhajizada/cradle"
  url "https://github.com/rhajizada/cradle/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5d6ffda4b2b4f591a0a4369ea0e73ab55261292f9f36bf0f537d3d297a79e671"
  license "MIT"
  head "https://github.com/rhajizada/cradle.git", branch: "main"

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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/cradle-0.1.0"
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
    assert_match version.to_s, shell_output("#{bin}/cradle --version")
  end
end
