class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.8"

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "e687c1d10a320d4745102f42f8404c1015b8296b3d83ab8e28c049efbb50824d"
    end

    on_intel do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-x86_64.tgz"
      sha256 "7c8bfc60931e155f46034b40e2a3372898c5b1c0cd538edc56d2eb4c5a505d82"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--help"
  end
end
