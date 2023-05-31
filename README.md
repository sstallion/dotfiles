<div align="center">
    <img src=".github/images/emacs.jpg"/>
</div>

# Configuration Files

This repository contains configuration files (aka dotfiles) managed by
[dotbot][1]. All major operating systems are supported including FreeBSD, Linux,
macOS, and Windows.

## Installation

Installation is straightforward and requires no dependencies apart from a recent
version of Python (3.8+). Symbolic links are created in the current user's home
directory; existing symbolic links will be overwritten. If a normal file or
directory exists, a warning will be issued and no action will be taken. One or
more profiles may be specified to install a non-default subset of files.

To install configuration files, issue:

    $ git clone git@github.com:sstallion/dotfiles.git && cd dotfiles
    $ python install.py [profiles ...]

See [More advanced setup][2] for details.

## Contributing

Pull requests are welcome! If a problem is encountered using this repository,
please file an issue on [GitHub][3].

## License

Source code in this repository is licensed under a Simplified BSD License. See
[LICENSE][4] for more details.

[1]: https://github.com/anishathalye/dotbot
[2]: https://github.com/anishathalye/dotbot/wiki/Tips-and-Tricks#more-advanced-setup
[3]: https://github.com/sstallion/dotfiles/issues
[4]: https://github.com/sstallion/dotfiles/blob/master/LICENSE
