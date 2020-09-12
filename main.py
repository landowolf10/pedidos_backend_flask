import pymysql
from app import app
from db_config import mysql
from flask import jsonify, request


@app.route('/users', methods=['POST'])
def insertClient():
    jsonData = request.json

    email = jsonData['email']
    nombre = jsonData['nombre']
    ap = jsonData['apellido_paterno']
    am = jsonData['apellido_materno']
    telefono = jsonData['telefono']
    estado = jsonData['estado']
    ciudad = jsonData['ciudad']
    colonia = jsonData['colonia']
    calle = jsonData['calle']
    numero = jsonData['numero']
    password = jsonData['pass']
    tipo_usuario = jsonData['tipo_usuario']
    firebase_token = jsonData['firebase_token']

    if request.method == 'POST':
        sql = "INSERT INTO usuarios(email, nombre, apellido_paterno, apellido_materno, telefono, estado, ciudad, colonia, calle, numero, pass, tipo_usuario, firebase_token) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        data = (email, nombre, ap, am, telefono, estado, ciudad, colonia, calle, numero, password, tipo_usuario, firebase_token)
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql, data)
        conn.commit()

        resp = jsonify('User added successfully!')
        resp.status_code = 200

        cursor.close()
        conn.close()

        return resp

@app.route('/users', methods=['GET'])
def getClients():
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT * FROM usuarios")
        rows = cursor.fetchall()
        resp = jsonify(rows)
        resp.status_code = 200
        
        return resp

    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    app.run()