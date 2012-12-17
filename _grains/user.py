import os


def user():
    return {'home': os.environ.get('HOME')}

