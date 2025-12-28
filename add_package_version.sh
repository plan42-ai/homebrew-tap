#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <package_name> <version>" >&2
  exit 1
fi

PACKAGE_NAME="$1"
VERSION="$2"

if [[ "${PACKAGE_NAME}" != "plan42-cli" ]]; then
  echo "Unsupported package name: ${PACKAGE_NAME}. This tap currently manages plan42-cli." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FORMULA_DIR="${SCRIPT_DIR}/Formula"
mkdir -p "${FORMULA_DIR}"

camelize() {
  local input="$1"
  local result=""
  input="${input//[^a-zA-Z0-9]/ }"
  for part in ${input}; do
    part="${part^}"
    result+="${part}"
  done
  echo "${result}"
}

version_suffix="${VERSION//[^0-9]/}"
if [[ -z "${version_suffix}" ]]; then
  echo "Version must contain at least one numeric character." >&2
  exit 1
fi

download_checksum() {
  local arch="$1"
  local url="https://github.com/plan42-ai/cli/releases/download/v${VERSION}/plan42-${VERSION}-macos-${arch}.tgz"
  local tmpfile
  tmpfile="$(mktemp)"
  if curl --fail --silent --location --retry 3 --output "${tmpfile}" "${url}"; then
    local checksum
    checksum="$(shasum -a 256 "${tmpfile}" | awk '{print $1}')"
    rm -f "${tmpfile}"
    echo "${checksum}"
    return 0
  fi

  rm -f "${tmpfile}"
  return 1
}

format_sha() {
  local checksum="$1"
  if [[ "${checksum}" == ":no_check" ]]; then
    echo ":no_check"
  else
    printf '"%s"' "${checksum}"
  fi
}

arm_sha=":no_check"
intel_sha=":no_check"

if [[ -n "${SKIP_CHECKSUM:-}" ]]; then
  echo "SKIP_CHECKSUM set; using :no_check for all architectures." >&2
else
  if arm_sha_result=$(download_checksum arm64); then
    arm_sha="${arm_sha_result}"
  else
    echo "Warning: failed to download arm64 tarball; falling back to :no_check." >&2
  fi

  if intel_sha_result=$(download_checksum x86_64); then
    intel_sha="${intel_sha_result}"
  else
    echo "Warning: failed to download x86_64 tarball; falling back to :no_check." >&2
  fi
fi

generate_formula() {
  local class_name="$1"
  local file_path="$2"
  cat > "${file_path}" <<RUBY
class ${class_name} < Formula
  desc "CLI for interacting with Plan42"
  homepage "https://github.com/plan42-ai/cli"
  license "BSD-2-Clause"
  version "${VERSION}"

  depends_on "container"

  on_macos do
    on_arm do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-arm64.tgz"
      sha256 $(format_sha "${arm_sha}")
    end

    on_intel do
      url "https://github.com/plan42-ai/cli/releases/download/v#{version}/plan42-#{version}-macos-x86_64.tgz"
      sha256 $(format_sha "${intel_sha}")
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
RUBY
}

package_class_name="$(camelize "${PACKAGE_NAME}")"
versioned_class_name="${package_class_name}AT${version_suffix}"

generate_formula "${package_class_name}" "${FORMULA_DIR}/${PACKAGE_NAME}.rb"
generate_formula "${versioned_class_name}" "${FORMULA_DIR}/${PACKAGE_NAME}@${VERSION}.rb"

echo "Generated formulas:"
echo "  ${FORMULA_DIR}/${PACKAGE_NAME}.rb"
echo "  ${FORMULA_DIR}/${PACKAGE_NAME}@${VERSION}.rb"
