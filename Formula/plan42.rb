class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.4"

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "6d3c5cef87f64fb306e0864f7ae906b756338141c44d03e727ec62d86aa35f6a"
    end

    on_intel do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-x86_64.tgz"
      sha256 "3eb414455573388694de299a95b90a9d0121e6ee5fe5b46c700474023078a9a5"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--help"
  end
end
