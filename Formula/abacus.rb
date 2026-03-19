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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "90fdeee0e0689cfde7aa4278af2c383e0a593a4bd4222acb96457d19632bec46"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "864f2af257d4353338f121f9f4ca52927a0c90bb2033f7ab9d43a5818d2e2204"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2dee2c5e48c6b56d0046e23437ff80e808b29bf5ab65769a0ac2d1f0a16d8019"
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
