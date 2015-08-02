if [ -d "/Applications/Google Chrome.app" ]; then
    echo "Already installed!"
    exit 0
fi
curl -fsSL https://dl.google.com/chrome/mac/dev/GoogleChrome.dmg > chrome.dmg
hdiutil mount chrome.dmg
cp -R '/Volumes/Google Chrome/Google Chrome.app' /Applications
