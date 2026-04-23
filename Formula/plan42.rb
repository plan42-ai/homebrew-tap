class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.46"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "fa61a0851c8509c65db206bcd47eaf594dceba66ae6bb94533cc2bd36de5e521"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--version"
  end
end
