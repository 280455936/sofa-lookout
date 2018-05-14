#!/bin/bash
shopt -s expand_aliases
if [ ! -n "$1" ] ;then
 echo "Please enter a version"
 exit 1
else
  echo "The version is $1 !"
fi
if [ `uname` == "Darwin" ]
 then
 echo "This is OS X"
 alias sed='sed -i ""'
else
 echo "This is Linux"
 alias sed='sed -i'
fi
echo "Change version in root pom.xml ===>"
sed "/<project /,/<packaging/ s/<version>.*<\/version>/<version>$1<\/version>/" pom.xml

echo "Change version in subproject pom ===>"
for filename in `find . -maxdepth 2 -mindepth 2  -name "pom.xml"`
  do
    echo "Deal with $filename"
    sed "/<parent>/,/<\/parent>/ s/<version>.*<\/version>/<version>$1<\/version>/" $filename
 done
