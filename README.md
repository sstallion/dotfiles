<div align="center">
    <img src=".github/images/emacs.jpg"/>
</div>

# Configuration Files

This repository contains configuration files (aka dotfiles) managed by
[dotbot][1]. All major operating systems are supported including FreeBSD, Linux,
macOS, and Windows.

## Installation

Installation requires no dependencies apart from Python 3.8+. Symbolic links are
created in the current user's home directory; existing symbolic links will be
overwritten. If a normal file or directory exists, a warning will be issued and
no action will be taken. One or more profiles may be specified to install a
non-default subset of files.

To install configuration files, issue:

    $ git clone git@github.com:sstallion/dotfiles.git && cd dotfiles
    $ python install.py [profiles ...]

See [More advanced setup][2] for details.

> **NOTE**: Installation must be performed in an administrative shell on
> Windows. See [Create symbolic links][3] for details.

## Contributing

Pull requests are welcome! If a problem is encountered using this repository,
please file an issue on [GitHub][4].

## License

Source code in this repository is licensed under a Simplified BSD License. See
[LICENSE][5] for more details.

[1]: https://github.com/anishathalye/dotbot
[2]: https://github.com/anishathalye/dotbot/wiki/Tips-and-Tricks#more-advanced-setup
[3]: https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/create-symbolic-links
[4]: https://github.com/sstallion/dotfiles/issues
[5]: https://github.com/sstallion/dotfiles/blob/master/LICENSE
