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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/cradle-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "11c37688e030176327c14aed850075962014098dbfe7992dd71fa9fb8ba517d2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c7d00fe74ff0ce25b3c7f301b80d5f40af51d2aaadb9a9f580c380cda4383a7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dda590f21c5766bbfee4475c6ec479db4b7222ac4efbcba8c0794076d74533d4"
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
