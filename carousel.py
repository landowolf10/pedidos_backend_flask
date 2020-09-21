import pymysql
from app import app
from db_config import mysql
from flask import jsonify, request, render_template
import os

@app.route('/', methods=['GET'])
def getImages():
    image_names = os.listdir('./static')
    print(image_names)

    return render_template('carousel.html', image_names=image_names)

if __name__ == '__main__':
    app.run()