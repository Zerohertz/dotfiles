<h2 align = "center">
    ⚫️ Zerohertz's Dotfiles ⚫️
</h2>

<div align="center">
<a href="macos"><img src="https://img.shields.io/badge/MacOS-000?style=for-the-badge&logo=apple" /></a>
<a href="linux"><img src="https://img.shields.io/badge/Ubuntu-000?style=for-the-badge&logo=ubuntu" /></a>
<br/>
<a href=".config/kitty/kitty.conf"><img src="https://img.shields.io/badge/Kitty-000?style=for-the-badge&logo=gnometerminal" /></a>
<a href=".zshrc"><img src="https://img.shields.io/badge/Zsh-000?style=for-the-badge&logo=zsh" /></a>
<a href="https://github.com/Zerohertz/nvim"><img src="https://img.shields.io/badge/Neovim-000?style=for-the-badge&logo=neovim" /></a>
<br/>
<a href="https://deepwiki.com/Zerohertz/dotfiles"><img src="https://deepwiki.com/badge.svg" alt="Ask DeepWiki"></a>
<img width="1773" alt="neovim" src="https://github.com/user-attachments/assets/15110871-bc98-4d9a-a855-c975638bb45a" />
</div>

---

<h4 align = "center">
    🛠️ Configs 🛠️
</h4>

- [Kitty](.config/kitty/kitty.conf)
- [Zsh](.zshrc)
- [Powerlevel10k](.p10k.zsh)
- [Neovim](https://github.com/Zerohertz/nvim)
- [Neovide](.config/neovide/config.toml)
- [tmux](.tmux.conf)
- [Karabiner](.config/karabiner)

<h4 align = "center">
    <a href="linux">🐧 Ubuntu 🐧</a>
</h4>

<!-- markdownlint-disable -->

```bash
$ make all
```

<!-- markdownlint-enable -->

<h4 align = "center">
    <a href="macos">💻 MacOS 💻</a>
</h4>

<!-- markdownlint-disable -->

```bash
$ make kitty
$ make all
$ make neovide
```

<!-- markdownlint-enable -->
<h4 align = "center">
    <a href="https://hub.docker.com/r/zerohertzkr/dev">🐳 Docker 🐳</a>
    <br/>
    <br/>
    <a href = "https://hub.docker.com/r/zerohertzkr/dev"><img src="https://img.shields.io/docker/v/zerohertzkr/dev?style=for-the-badge&logo=Docker&label=zerohertzkr/dev&labelColor=800a0a"/></a>
</h4>

<!-- markdownlint-disable -->

```bash
$ docker run \
        --name $name \
        --platform linux/amd64 \
        -v ./:/home/zerohertz/workspace \
        --rm -d \
        zerohertzkr/dev
$ docker exec -it $name zsh
```

<!-- markdownlint-enable -->
