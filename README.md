# asdf-aws-vault
![GitHub Actions Status](https://github.com/karancode/asdf-aws-vault/workflows/Main%20workflow/badge.svg?branch=main)  
[aws-vault](https://github.com/ByteNess/aws-vault) plugin for [asdf](https://github.com/asdf-vm/asdf) version manager

## Install

```
asdf plugin-add aws-vault https://github.com/karancode/asdf-aws-vault.git
asdf install aws-vault <version>
```

## Use

Check out the [asdf documentation](https://asdf-vm.com/guide/getting-started.html#_5-install-a-version) for instructions on how to install and manage versions of aws-vault.

## Supported platforms

macOS and Linux on `amd64`/`arm64`, using `aws-vault` `>= 7.5.0` (earlier versions predate the [ByteNess](https://github.com/ByteNess/aws-vault) fork's per-platform binaries, so only `>= 7.5.0` is listed). Other platforms such as FreeBSD and Linux `ppc64le` work for some versions but are not guaranteed.

## Credits

- [asdf-kubectl](https://github.com/asdf-community/asdf-kubectl) plugin
- [asdf-plugin-template](https://github.com/asdf-vm/asdf-plugin-template)
