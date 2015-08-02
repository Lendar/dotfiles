if [ -d "/Applications/Google Chrome Canary.app" ]; then
    echo "Already installed!"
    exit 0
fi
curl -fsSL https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg > chrome-canary.dmg
hdiutil attach chrome-canary.dmg
cp -R '/Volumes/Google Chrome Canary/Google Chrome Canary.app' /Applications
hdiutil detach '/Volumes/Google Chrome Canary'
