# Configuration Files

This repository contains various configuration files (aka dotfiles) that are
shared between multiple systems.

<div align="center">
    <img src=".github/images/emacs.jpg"/>
</div>

## Installation

Installation is straightforward; symbolic links are created in the current
user's home directory for each file tracked. Existing symbolic links will be
overwritten; however, if a normal file or directory exists a warning will be
issued and no action will be taken.

    $ git clone git@github.com:sstallion/dotfiles.git .dotfiles && cd $_
    $ ./install.sh

## Contributing

Pull requests are welcome! If a problem is encountered using this repository,
please file an issue on [GitHub][1].

## License

Source code in this repository is licensed under a Simplified BSD License. See
[LICENSE] for more details.

[1]: https://github.com/sstallion/dotfiles/issues
[2]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

[LICENSE]: LICENSE
