class Signum < Formula
  desc "SVG badge generator written in Go"
  homepage "https://github.com/rhajizada/signum"
  url "https://github.com/rhajizada/signum/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a073378f312030449ce579a4c53f2eb06847d3fcaf6c86994b8c2c21181dd9e4"
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3fe8cd9410b98aef11def2ba2c09dfa2418336be850104bfbd5842a855fdf8a4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "95baffb2b98422ef4a16f17f8085e7cf382f14a494dfe89d1e945b0bddb815b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cd09622bc365cd6a50d1b48a57107d57a8e57ef844bd29ba66da5ee6225a6080"
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
