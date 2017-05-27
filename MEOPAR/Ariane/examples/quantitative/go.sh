#!/bin/sh

test $# = 0 && { echo "name of directory must be provided..." ; exit ;}
test -d $1 || mkdir $1

grep -hv '^@' segments > sections.txt

/bin/mv sections.txt $1
cd $1

ln -fs ../namelist namelist
ln -fs ../region_limits region_limits

# We assume that the ariane executable is in the PATH environment variable !
# We are going to test this assumption:

type ariane
if (($? != 0))
then
    echo "ariane is not present in you PATH."
    echo "Please update your PATH environment variable:"
    echo ""
    echo '        setenv PATH /ocean/gsgarbi/MEOPAR/Ariane/bin:${PATH}    (csh)'
    echo '        export PATH=/ocean/gsgarbi/MEOPAR/Ariane/bin:${PATH}    (ksh)'
    echo ""
    echo "- STOP -"
    exit
fi

# Let's go
ariane

