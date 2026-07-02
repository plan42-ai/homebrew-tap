class Plan42 < Formula
  desc "CLI for Plan42.ai"
  homepage "https://github.com/plan42-ai/cli"
  version "1.0.56"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 "9f2005c935ddc36b5d27d76f087c24073b8673cb749227fb4554720fb267b33f"
    end
  end

  def install
    bin.install Dir["**/bin/*"]
  end

  test do
    system "bin/plan42", "--version"
  end
end
