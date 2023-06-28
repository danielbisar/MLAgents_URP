#!/bin/bash

set -e

# the file /etc/locale.gen contains different locale values
# uncomment the one you want to use, in this case: en_US.UTF-8
# -i = inplace editing
sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen

# generate the locale
locale-gen

# print locales, since previous command might output "cannot set locale", so we proof it was set correct, to avoid
# confusion
echo "Locale setup successfully"
locale
