# frozen_string_literal: true

# Formula for the openfabriq/homebrew-tap repository: brew install openfabriq/tap/openfabriq.
# The tap's workflow keeps url and sha256 on npm's latest version, every hour; change the rest here, then copy it to the tap.
class Openfabriq < Formula
  desc "Run a software factory described in your repository, with your Claude Code"
  homepage "https://openfabriq.dev"
  url "https://registry.npmjs.org/openfabriq/-/openfabriq-0.1.6.tgz"
  sha256 "1ae14f23b133b636ee7db6c4e9f9b19b58901a694cea6089c093ede6ebeab3eb"
  license "Apache-2.0"

  depends_on "gh"
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      openfabriq runs your Claude Code, which Homebrew does not install as a dependency:
        brew install --cask claude-code
      Then log in once:
        claude auth login && gh auth login
      The first openfabriq init, plan, apply, start or run says what is still missing.
    EOS
  end

  test do
    assert_match "Usage: openfabriq", shell_output(bin/"openfabriq")
    system "git", "init", "--quiet"
    system bin/"openfabriq", "init", "--example", "01-quickstart"
    assert_match "is valid", shell_output("#{bin}/openfabriq validate")
  end
end
