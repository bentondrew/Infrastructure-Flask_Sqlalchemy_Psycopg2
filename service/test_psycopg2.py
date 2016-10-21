from flask import Flask
app = Flask(__name__)


@app.route('/')
def index():
  import psycopg2
  return 'psycopg2 version installed: {}'.format(psycopg2.__version__)
