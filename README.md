# unown

```sh
git clone git@github.com:dangkhoasdc/unown ~/.config/nvim
nvim
```

## Requirements

- [node >= 20](https://nodejs.org/en/download)
- [ripgrep](https://github.com/burntsushi/ripgrep#installation)
- treesitter-cli (better build from source though; some old Ubuntu version doesn't support running from `binstall` version)

```bash
curl https://sh.rustup.rs -sSf | sh
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall tree-sitter-cli
```
