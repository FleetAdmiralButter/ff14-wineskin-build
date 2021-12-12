#!/bin/sh

WINESKIN_TARGET_NAME="template_xiv_working.app"

wrapperWine=""
winetricks=""
prefix=""

function boot() {
	wrapperWine="$PWD/template_xiv_working.app/Contents/SharedSupport/wine/bin"
	export PATH="$PATH:$wrapperWine"

	winetricks="$PWD/template_xiv_working.app/Wineskin.app/Contents/Resources/winetricks"

	prefix="$PWD/template_xiv_working.app/Contents/Resources"
	export WINEPREFIX=$prefix
}

function install_deps() {
	$winetricks dotnet40
	$winetricks dotnet40_kb2468871
	$winetricks dotnet472
	$winetricks vcrun2015
	$winetricks vcrun2012
	$winetricks vcrun2010
	#$winetricks corefonts
}

echo "==> Removing Gatekeeper quarantine from downloaded wrapper. You may need to enter your password."
sudo xattr -r -d com.apple.quarantine "$PWD/$WINESKIN_TARGET_NAME" &>/dev/null

echo "==> Start bootstrap of the Wine environment."
boot
echo "==> Try to validate the bootstrap."
$winetricks list-installed &>/dev/null
isWorkingEnv=$?

if [ "$isWorkingEnv" != "0" ]; then
	echo "==> Could not validate that the Wine environment is working correctly, sorry."
	exit 1;
fi

echo "==> Finished bootstrapping the Wine environment."

echo "==> Installing proprietary dependencies..."
install_deps
echo "==> Finished installing dependencies."
