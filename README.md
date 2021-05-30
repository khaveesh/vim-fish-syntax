# vim-fish-syntax

Syntax and ftplugin files for [fish
shell](https://github.com/fish-shell/fish-shell) scripts

## Installation

I recommend the native packages support built into Vim8 and NeoVim, but
you can use any plugin manager you like.

## Features aplenty

-   Syntax highlighting and filetype detection, of course.
-   Code formatting with `fish_indent`.
-   Omni-complete from fish using the `^X^O` command.

For everything above to work you need to have fish installed in `$PATH`
and some Vim features turned on. First, tell Vim to use the syntax and
filetype functionality, normally in your `~/.vimrc`:

``` {.vim}
syntax enable
filetype plugin indent on
```

The above commands are required only for Vim and not for NeoVim.

## Teach a Vim to fish...

Vim needs a more POSIX compatible shell than fish for certain
functionality to work, such as `:%!`, compressed help pages and many
third-party addons. If you use fish as your login shell or launch Vim
from fish, you need to set `shell` to something else in your `~/.vimrc`,
for example:

``` {.vim}
if &shell =~# 'fish$'
    set shell=sh
endif
```

Best do it somewhere at the top, before any addon code is loaded and
executed.
