#!/usr/bin/env bash
# install.sh - install dotfiles to $HOME

set -e

echo "Updating submodules..."
git submodule update --init --recursive

# Ensure files are installed relative to $HOME if possible; the following
# makes use of parameter expansion rather than relying on GNU coreutils:
prefix=$(readlink -f "${PWD}")
prefix="${prefix#*${HOME}/}"

# Link each file to the home directory iff the file does not exist or is
# already a symbolic link. This will probably annoy someone, eventually.
for target_file in files/*; do
	target_file="${prefix}/${target_file}"
	source_file="${HOME}/.${target_file##*/}"
	if [[ -e "${source_file}" && ! -h "${source_file}" ]]; then
		echo "Skipping ${source_file}; not a symbolic link"
	else
		echo "Installing ${source_file}..."
		ln -fns "${target_file}" "${source_file}"
	fi
done

# Ruby requires GNU make when building extensions; we prefer use of gmake on
# platforms that support multiple make variants:
make=make
if command gmake --version &>/dev/null; then
	make=gmake
fi

echo "Updating Command-T..."
ext_dir="files/vim/bundle/command-t/ruby/command-t/ext/command-t"
(cd "${ext_dir}" && ruby extconf.rb && "${make}" clean all)

if command lesskey &>/dev/null; then
	echo "Updating lesskey file..."
	lesskey
fi

echo "Done."
exit 0
