#!/bin/sh -e
# install.sh - install dotfiles to $HOME

echo "Updating submodules..."
git submodule update --init --recursive

# Link each file to the home directory iff the file does not exist or is
# already a symbolic link. This will probably annoy someone, eventually.
for file in `pwd`/files/*; do
    link_name="$HOME/.`basename $file`"
    if [ -e $link_name -a ! -h $link_name ]; then
        echo "Skipping $link_name; not a symbolic link"
    else
        echo "Installing $link_name..."
        ln -sfT $file $link_name
    fi
done

echo "Done."
exit 0
