#!/usr/bin/env bash
function link_file {
	source="${PWD}/$1"
	target="${HOME}/${1/_/.}"
    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi
	ln -sf ${source} ${target}
}

function sub_link_file {
	source="${PWD}/$1"
	file=${1##*/}
	target="${HOME}/${file/_/.}"
    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi
	ln -sf ${source} ${target}
}

for i in _vim/_*
do
	sub_link_file $i
done

for i in _*
do
	link_file $i
done

git submodule sync
git submodule init
git submodule update
git submodule foreach 'git checkout master'
git submodule foreach 'git submodule init'
git submodule foreach 'git submodule update'
