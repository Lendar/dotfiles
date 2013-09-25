if [ -d "/Applications/Google Chrome Canary.app" ]; then
    echo "Already installed!"
    exit 0
fi
curl -qL https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg > chrome-canary.dmg
hdiutil mount chrome-canary.dmg
cp -R '/Volumes/Google Chrome Canary/Google Chrome Canary.app' /Applications
