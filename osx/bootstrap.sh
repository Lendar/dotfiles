# Install http://mxcl.github.com/homebrew/
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# https://github.com/msabramo/homebrew-saltstack
brew tap singingwolfboy/saltstack

# Python
brew install python
PATH=/usr/local/bin:$PATH

brew install swig
pip install M2Crypto PyCrypto

pip install msgpack-python pyzmq PyYAML jinja2

brew install saltsack

# Manual way:
#   brew install python
#   brew install zeromq # for salt
#   brew install swig   # for salt
#   pip install salt
