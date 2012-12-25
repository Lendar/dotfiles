if [ -d /Applications/Alfred.app ]; then
    echo "Already installed!"
    exit 0
fi
binary_name="alfred_1.3.1_261.dmg"
binary_url="http://cachefly.alfredapp.com/$binary_name"
curl -qLO $binary_url
hdiutil mount $binary_name
cp -R '/Volumes/Alfred.app/Alfred.app' /Applications
