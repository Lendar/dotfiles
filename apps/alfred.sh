if [ -d "/Applications/Alfred 2.app" ]; then
    echo "Already installed!"
    exit 0
fi
binary_name="Alfred_2.0.8_212.zip"
binary_url="http://cachefly.alfredapp.com/$binary_name"
curl -qLO $binary_url
unzip $binary_name -d /Applications
