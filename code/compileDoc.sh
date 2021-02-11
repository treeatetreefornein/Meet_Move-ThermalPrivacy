#!/bin/sh

if [ $# -eq 0 ]
	then
		echo "No agruments given"
		exit 1
fi

doc="$(echo $1 | grep -o "^\w*[^.]" | tr -d '\n')"
refer="references"
                                        #special chars#
refer -e -p ${refer} "${doc}.ms" | groff -Kutf8 -Tutf8 -Tps -t -e -ms > "${doc}.ps"
ps2pdf "${doc}.ps"
rm "${doc}.ps"
