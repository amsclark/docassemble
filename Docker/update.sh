#! /bin/bash

export DA_ROOT="${DA_ROOT:-/usr/share/docassemble}"
if [ "${DAPYTHONVERSION:-2}" == "2" ]; then
    export DA_DEFAULT_LOCAL="local"
else
    export DA_DEFAULT_LOCAL="local3.5"
fi

export DA_ACTIVATE="${DA_PYTHON:-${DA_ROOT}/${DA_DEFAULT_LOCAL}}/bin/activate"

source "${DA_ACTIVATE}"

export CONTAINERROLE=":${CONTAINERROLE:-all}:"
export HOME=/var/www

export DA_CONFIG_FILE="${DA_CONFIG:-${DA_ROOT}/config/config.yml}"
source /dev/stdin < <(source $DA_ACTIVATE && python -m docassemble.base.read_config $DA_CONFIG_FILE)

set -- $LOCALE
export LANG=$1

python -m docassemble.webapp.update

exit 0
