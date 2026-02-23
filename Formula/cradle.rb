class Cradle < Formula
  desc "CLI to build and launch Docker images with a consistent, pre-configured setup"
  homepage "https://github.com/rhajizada/cradle"
  url "https://github.com/rhajizada/cradle/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "d55d6184553542e01f31d67a62fa40846fe5a9c67b4b0d82445605a387ea7911"
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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/cradle-0.2.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9de5a2365659429da74fb8495fa3ca4f540484753b5875dd248d53ba62c80e3e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "bf086c2c9b76c7146ad6d79546a5ac1f1f744a6a4767fb2fd461f78d7f2a010e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "45ef810962129ac59a8bad132035aaf694944eba6f4ce10f51c9fb1447ef615c"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/cradle"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cradle --version")
  end
end
