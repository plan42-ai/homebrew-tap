class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.55"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "05cadefd76d6cec17c0780bedd6de1ca2fa77685dddbc4245ff36a1a80b6e21e"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--version"
  end
end
