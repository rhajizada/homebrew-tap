class Cradle < Formula
  desc "CLI to build and launch Docker images with a consistent, pre-configured setup"
  homepage "https://github.com/rhajizada/cradle"
  url "https://github.com/rhajizada/cradle/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a073378f312030449ce579a4c53f2eb06847d3fcaf6c86994b8c2c21181dd9e4"
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9be93a8ea85bef02fb08cf2d0365c684afb09f0fe7db56b6ae5ce4e97be9613f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "393792357dd169c2e8b11a2204391af494223dfe6cf103e255973f36d6d9c660"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a125bde7e485249bf0fb353594082ce19039f176ce85aaa8644a6add19e1f555"
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
