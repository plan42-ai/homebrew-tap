class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.26"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "40f9a1c035bf2be0478b5d29ad1018ae61c757a303178e5a2980e754a59ff99d"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--version"
  end
end
