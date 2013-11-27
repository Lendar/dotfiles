import os


def user():
    return {
        'home': os.environ.get('HOME'),
        'user': os.environ.get('USER')
    }

