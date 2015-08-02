if [ -d /Applications/Dropbox.app ]; then
    echo "Already installed!"
    exit 0
fi
binary_name="download?plat=mac"
binary_url="https://www.dropbox.com/$binary_name"
curl -fsSLO $binary_url
hdiutil mount $binary_name
cp -R '/Volumes/Dropbox Installer/Dropbox.app' /Applications
