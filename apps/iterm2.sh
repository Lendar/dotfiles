if [ -d "/Applications/iTerm.app" ]; then
    echo "Already installed!"
    exit 0
fi
curl -fsSL https://iterm2.com/downloads/beta/iTerm2-2_9_20150626.zip > iTerm2.zip
unzip -q iTerm2.zip -d /Applications
