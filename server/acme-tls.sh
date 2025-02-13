#!/bin/sh

. ../includes/classic_sh/init_required.sh;
#. ../includes/classic_sh/package_management.sh;

include ../includes/class_sh/package_management.sh;

main() {

    install_acme_sh;
}

install_acme_sh() {

    echo hi;
    install_program 'git';
}

main;