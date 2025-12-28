class Plan42CliAT104 < Formula
  desc "CLI for interacting with Plan42"
  homepage "https://github.com/plan42-ai/cli"
  license "BSD-2-Clause"
  version "1.0.4"

  depends_on "container"

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 :no_check
    end

    on_intel do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-x86_64.tgz"
      sha256 :no_check
    end
  end

  on_linux do
    odie "plan42-cli is only available on macOS."
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    cd "plan42-#{version}-macos-#{arch}" do
      bin.install Dir["bin/*"]
    end
  end

  test do
    output = shell_output("#{bin}/plan42 --help")
    assert_match "runner", output
  end
end
