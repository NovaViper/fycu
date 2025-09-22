# _FYCU - Fish You Could Use_

A fish plugin that reminds you to use your aliases and abbreviations!
FYCU (pronounced FEYE-COO) is a complete rewrite of the original [Fish You Should Use plugin](https://github.com/paysonwallach/fish-you-should-use) with bug fixes and new features.

# Table of Contents

- Installation
- Usage
- Configuration
- Contributing

# noted

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

```
home-manager.users.USER = {
    programs.fish.plugins = {
        {
        name = "fycu";
        src = pkgs.fetchFromGithub {
            owner = "NovaViper";
            repo = "fycu";
            rev = "OBTAIN FROM GITHUB";
            sha256 = "OBTAIN WITH nix-prefetch-url
            https://github.com/NovaViper/fycu";
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
by setting teh value of `FYCU_MESSAGE_POSITION`.

```
set --global FYCU_MESSAGE_POSITION "after"
```

## Disable Hints for Specific Aliases/Abbreviations

You can tell `fycu` to permanently ignore certain aliases/abbreviations by
including them in the `FYCU_IGNORED_ALIASES`

```
set -g FYCU_IGNORED_ALIASES "ls,fd"
```

## Hardcore Mode

Not implemented, or may not be implemented due to issues noted in
[TODO](TODO.md)

# Contributing

Pull Requests and Feedback are welcomed!

This is my very first fish plugin so there are bound to be bugs so feel free to
[open an issue](https://github.com/NovaViper/fycu/issues/new) or [open a pull
request](https://github.com/NovaViper/fycu/compare)! I also have a
[TODO](TODO.md) list for upcoming features I plan to add.
