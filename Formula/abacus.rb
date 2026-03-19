class Abacus < Formula
  desc "CLI to benchmark OpenAI-compatible inference APIs"
  homepage "https://github.com/rhajizada/abacus"
  url "https://github.com/rhajizada/abacus/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "691e7444395786b6d2bfb9c127bc6ab35f731bf09a84a9a0cbccfa128ba8c628"
  license "MIT"
  head "https://github.com/rhajizada/abacus.git", branch: "main"

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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/abacus-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9de5a2365659429da74fb8495fa3ca4f540484753b5875dd248d53ba62c80e3e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "bf086c2c9b76c7146ad6d79546a5ac1f1f744a6a4767fb2fd461f78d7f2a010e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "45ef810962129ac59a8bad132035aaf694944eba6f4ce10f51c9fb1447ef615c"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/abacus"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/abacus --version")
  end
end
