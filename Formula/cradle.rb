class Cradle < Formula
  desc "CLI to build and launch Docker images with a consistent, pre-configured setup"
  homepage "https://github.com/rhajizada/cradle"
  url "https://github.com/rhajizada/cradle/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9fd5fdfe3893861557b740bb36da394c4dd15fb9502c505324b850e4f4daacee"
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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/cradle-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d7953614d839f1928c1e756421b06a8189f6412d656d1445bb1829dda5770a32"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "08ad1c39d60b1d6471b24015392e7be50dd94aea7774ebc327731a56cab509b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9ebd357dda48b9d96185c986e06e1197c5daf7bf09c83725ea3394ee7ec76904"
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
