class Donezo < Formula
  desc "Simple TUI to-do app written in Go using Bubble Tea and SQLite"
  homepage "https://github.com/rhajizada/donezo"
  url "https://github.com/rhajizada/donezo/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "6d18315b4b332c2a3064433497b9885db59a90341aa79c5d3aae978cec4a6ead"
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
    root_url "https://github.com/rhajizada/homebrew-tap/releases/download/donezo-0.2.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8bbd396458be87336893107fd789154339d1c96593ac9c786f9ad297dd203afa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a22278ec08663887f006bdd3aa67e710a3ee1b15c73b890539b08cdc5000709c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "72ad5cdca80f8d6fd1c06918ea4394b89b17ab0e7622d69ceefffc85a356771d"
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
