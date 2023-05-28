#!/usr/bin/env bash
path_of_here=$(dirname "$0")

# Install starship for beautiful and git theme
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Install ble.sh for autocomplete stuff
echo path of here is "${path_of_here}"
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
mkdir -p "${path_of_here}"/blesh
cp -Rf ble-nightly/* "${path_of_here}"/blesh/
rm -rf ble-nightly
final_path="${path_of_here}/blesh/ble.sh"
echo "source ${final_path}" >> ~/.bashrc
