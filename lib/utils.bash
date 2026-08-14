#!/usr/bin/env bash

# Shared helpers for the aws-vault asdf plugin, sourced by bin/download,
# bin/install, and bin/list-all.

TOOL_NAME="aws-vault"
GH_REPO="https://github.com/ByteNess/aws-vault"

# Minimum aws-vault version whose ByteNess release ships the per-platform
# binaries this plugin installs (aws-vault-<os>-<cpu>). See bin/list-all.
MIN_MAJOR=7
MIN_MINOR=5

get_arch() {
    uname | tr '[:upper:]' '[:lower:]'
}

get_cpu() {
    local machine_hardware_name
    machine_hardware_name="$(uname -m)"

    # On Apple Silicon, a shell running under Rosetta 2 reports "x86_64".
    # Detect the translation and correct to the native arm64 so we don't
    # download an amd64 binary onto arm64 hardware.
    if [ "$machine_hardware_name" = "x86_64" ] && [ "$(uname)" = "Darwin" ]; then
        if [ "$(sysctl -n sysctl.proc_translated 2>/dev/null)" = "1" ]; then
            machine_hardware_name="arm64"
        fi
    fi

    case "$machine_hardware_name" in
        'x86_64' | 'amd64') echo "amd64" ;;
        'aarch64' | 'arm64') echo "arm64" ;;
        'powerpc64le' | 'ppc64le') echo "ppc64le" ;;
        *) echo "$machine_hardware_name" ;;
    esac
}

get_download_url() {
    local version="$1"
    echo "${GH_REPO}/releases/download/v${version}/${TOOL_NAME}-$(get_arch)-$(get_cpu)"
}

# Download the aws-vault binary for $version into $output_path, failing with a
# clear message when no matching asset exists.
download_binary() {
    local version="$1"
    local output_path="$2"
    local url
    url="$(get_download_url "$version")"

    echo "Downloading ${TOOL_NAME} from ${url}"
    if ! curl -sfL "$url" -o "$output_path"; then
        rm -f "$output_path"
        >&2 echo "Error: could not download ${TOOL_NAME} v${version} for $(get_arch)-$(get_cpu)."
        >&2 echo "This plugin supports ByteNess binaries from v7.5.0 onward; this version may be unavailable for your platform."
        >&2 echo "URL: ${url}"
        exit 1
    fi
}
