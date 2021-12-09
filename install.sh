#!/bin/bash

# Bootstrap the Wine environment
wrapperWine="$PWD/D3.app/Contents/SharedSupport/wine/bin"
export PATH="$PATH:$wrapperWine"
echo "Using $wrapperWine as PATH"

winetricks="$PWD/D3.app/Wineskin.app/Contents/Resources/winetricks"
echo "Using winetricks at $winetricks"

prefix="$PWD/D3.app/Contents/Resources"
echo "Using prefix $prefix"
export WINEPREFIX=$prefix

$winetricks list-installed

echo "Installing dependencies..."

$winetricks dotnet40
$winetricks dotnet40_kb2468871
$winetricks vcrun2015
$winetricks vcrun2012
$winetricks vcrun2010
$winetricks corefonts