if [ -d "/Applications/Alfred 2.app" ]; then
    echo "Already installed!"
    exit 0
fi
binary_name="Alfred_2.7.1_387.zip"
binary_url="https://cachefly.alfredapp.com/$binary_name"
curl -fsSLO $binary_url
unzip -q $binary_name -d /Applications
