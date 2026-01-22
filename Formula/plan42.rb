class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.30"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "d0d6d94112f5f9b5497456c328e690778bda0f52404c339fc99803a85bf2375e"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--version"
  end
end
