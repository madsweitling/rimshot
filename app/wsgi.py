# -*- coding: utf-8 -*-

from flask import Flask

app = Flask(__name__)


@app.route('/', methods=['GET'])
def index():
    return 'Hello world!'


def test():
    app.run(debug=True)

if __name__ == '__main__':
    test()
