#!/bin/sh -e
# install.sh - install dotfiles to $HOME

echo "Updating submodules..."
git submodule update --init --recursive

# Link each file to the home directory iff the file does not exist or is
# already a symbolic link. This will probably annoy someone, eventually.
for target in files/*; do
	link_name=$HOME/.`basename $target`
	if [ -e $link_name -a ! -h $link_name ]; then
		echo "Skipping $link_name; not a symbolic link"
	else
		echo "Installing $link_name..."
		ln -fns $PWD/$target $link_name
	fi
done

echo "Updating Command-T..."
extdir=files/vim/bundle/command-t/ruby/command-t/ext/command-t
(cd $extdir && ruby extconf.rb && make all)

echo "Updating lesskey file..."
lesskey

echo "Done."
exit 0
