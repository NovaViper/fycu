# _FYCU - Fish You Could Use_

A fish plugin that reminds you to use your aliases and abbreviations!
FYCU (pronounced FEYE-COO) is a complete rewrite of the original [Fish You Should Use plugin](https://github.com/paysonwallach/fish-you-should-use) with bug fixes and new features.

# Table of Contents

- [Installation](#Installation)
- [Usage](#Usage)
- [Configuration](#Configuration)
- [Contributing](#Contributing)
- [Credits](#Credits)

# Noted

The plugin is in very active development and is considered in an alpha state, so
there will be bugs! You have been warned

# Installation

[Fisher](https://github.com/jorgebucaran/fisher)

```
fisher install NovaViper/fycu
```

[NixOS](https://nixos.org)

NixOS Module
(TBA)

[Home-Manager module](https://nix-community.github.io/home-manager)

```Nix
home-manager.users.USER = {
    programs.fish.plugins = {
        {
            name = "fycu";
            src = pkgs.fetchFromGithub {
                owner = "NovaViper";
                repo = "fycu";
                rev = "OBTAIN FROM GITHUB";
                sha256 = "OBTAIN WITH `nix-prefetch-url https://github.com/NovaViper/fycu`";
            };
        }
    };
};
```

# Usage

You don't need to do anything extra! Once the plugin's installed, `fycu` will
let you know if you wrote a command that has an existing alias or abbreviation.
Also, with the way fish shell aliases function, `fycu` cannot tell a local from
a global alias/abbreviation.

(PICTURE HERE)

`fycu` can detect git aliases

(PICTURE HERE)

and abbreviations!

(PICTURE HERE)

# Configuration

## Message Position

By default, `fycu` will display its reminder messages _before_ a command has
executed. However, you can change it to display _after_ a command has executed
by setting the value of `FYCU_MESSAGE_POSITION`.

```
set --global FYCU_MESSAGE_POSITION "after"
```

## Enable Experimental Abbreviation Support

Since there are still pressing bugs in the abbreviation detection, I've left the
mode disabled with `FYCU_ENABLE_ABBR` set to `false`. If you wish to try it out,
then simply set it to `true`

## Disable Hints for Specific Aliases/Abbreviations

You can tell `fycu` to permanently ignore certain aliases/abbreviations with a
couple of different options:

You can set `FYCU_IGNORED_ALIASES` for standard aliases

```
set --global FYCU_IGNORED_ALIASES "ls,fd"
```

set `FYCU_IGNORED_GIT_ALIASES` for git aliases

```
set --global FYCU_IGNORED_GIT_ALIASES "reword,rewrite"
```

and `FYCU_IGNORED_GIT_ALIASES` for abbreviations.

```
set --global FYCU_IGNORED_ABBRS "jd,n"
```

These variables are verified using `_fycu_init_variables`, which is ran during
plugin startup. This function can also be manually executed by calling it again
in the session. If the variables are formatted correctly, then there will be no
errors logged in the terminal.

## Hardcore Mode

Not implemented, or may not be implemented due to issues noted in
[TODO](TODO.md)

# Contributing

Pull Requests and Feedback are welcomed!

This is my very first fish plugin so there are bound to be bugs so feel free to
[open an issue](https://github.com/NovaViper/fycu/issues/new) or [open a pull
request](https://github.com/NovaViper/fycu/compare)! I also have a
[TODO](TODO.md) list for upcoming features I plan to add.

# Credits

The plugin's development wouldn't have been possible without Llakala's help!
Additionally:

- Rewritten from [Fish You Should Use plugin](https://github.com/paysonwallach/fish-you-should-use), which is a port of [zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
- Abbreviation detection from
  [fish-abbreviation-tips](https://github.com/gazorby/fish-abbreviation-tips)
  and behavior inspiration from [zsh-abbr](https://zsh-abbr.olets.dev/)
