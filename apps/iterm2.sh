if [ -d "/Applications/iTerm.app" ]; then
    echo "Already installed!"
    exit 0
fi
curl -qL http://www.iterm2.com/downloads/stable/iTerm2_v1_0_0.zip > iTerm2_v1_0_0.zip
unzip iTerm2_v1_0_0.zip -d /Applications