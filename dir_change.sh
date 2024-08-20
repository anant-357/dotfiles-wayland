#!/bin/bash
dir_name=$1
mkdir .config
mv $dir_name/* .config
mv .config $dir_name
