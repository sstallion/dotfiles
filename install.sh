#!/bin/sh -e
# install.sh - install dotfiles to $HOME

echo "Updating submodules..."
git submodule update --init --recursive

echo "Updating permissions..."
chmod 0700 files/ssh
chmod 0600 files/ssh/config

# Link each file to the home directory iff the file does not exist or is
# already a symbolic link. This will probably annoy someone, eventually.
for target in files/*; do
	link_name=$HOME/.`basename $target`
	if [ -e $link_name -a ! -h $link_name ]; then
		echo "Skipping $link_name; not a symbolic link"
	else
		echo "Installing $link_name..."
		ln -fs -T $PWD/$target $link_name
	fi
done

echo "Updating lesskey file..."
lesskey

echo "Done."
exit 0
