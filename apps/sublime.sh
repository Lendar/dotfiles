if [ -d "/Applications/Sublime Text 2.app" ]; then
    echo "Already installed!"
    exit 0
fi
curl -fsSL http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202%20Build%202220.dmg > sublime.dmg
hdiutil mount sublime.dmg
cp -R '/Volumes/Sublime Text 2/Sublime Text 2.app' /Applications
