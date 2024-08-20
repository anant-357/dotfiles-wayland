#!/bin/bash

dir_name=$1

mkdir temp
mv $dir_name/.config/* temp
mkdir $dir_name/.config/$dir_name
mv temp/* $dir_name/.config/$dir_name

