curl -qL https://dl.google.com/chrome/mac/dev/GoogleChrome.dmg > chrome.dmg
hdiutil mount chrome.dmg
cp -R '/Volumes/Sublime Text 2/Sublime Text 2.app' /Applications
