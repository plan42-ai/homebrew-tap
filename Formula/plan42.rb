class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.7"

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "0396306238f8888f759b6ce4c0e95c81aaed2cf826811bc6b8b8a727ba6ae94f"
    end

    on_intel do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-x86_64.tgz"
      sha256 "7c6f5f789913967c8c7f5e1286828d919ab3ba030ebe7e882b3f128e27cb7556"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--help"
  end
end
