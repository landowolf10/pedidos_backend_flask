import pymysql
from app import app
from db_config import mysql
from flask import jsonify, request
import json
import requests
from pyfcm import FCMNotification


@app.route('/users', methods=['POST'])
def insertClient():
    try:
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

        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('insertar_usuario', (email, nombre, ap, am, telefono, estado, ciudad, colonia, calle, numero, password, tipo_usuario, firebase_token))
        conn.commit()

        resp = jsonify('User added successfully!')
        resp.status_code = 200

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/users', methods=['GET'])
def getClients():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('spGetUsers')
        rows = cursor.fetchall()
        resp = jsonify(rows)
        resp.status_code = 200
        
        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/users/<id>', methods=['PUT'])
def updateClient(id):
    try:
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

        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('update_user', (id, email, nombre, ap, am, telefono, estado, ciudad, colonia, calle, numero, password, tipo_usuario, firebase_token))
        conn.commit()

        resp = jsonify('User updated successfully!')
        resp.status_code = 200

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/users/<id>', methods=['DELETE'])
def deleteClient(id):
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('delete_user', (id))
        conn.commit()

        resp = jsonify('User deleted successfully!')
        resp.status_code = 200

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/login', methods=['POST'])
def login():
    try:
        jsonData = request.json

        email = jsonData['email']
        password = jsonData['pass']
        firebase_token = jsonData['firebase_token']

        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('login', (email, password, firebase_token))
        conn.commit()

        for row in cursor:
            data = row

            id_usuario = data[0]
            tipo_usuario = data[12]
            nombre = data[2]
            ap = data[3]
            am = data[4]
            telefono = data[5]
            colonia = data[8]
            calle = data[9]
            numero = data[10]

        jsonRecords = {
                "email": email,
                "pass": password,
                "id": id_usuario,
                "tipo_usuario": tipo_usuario,
                "nombre": nombre,
                "apellido_paterno": ap,
                "apellido_materno": am,
                "telefono": telefono,
                "colonia": colonia,
                "calle": calle,
                "numero": numero,
        }

        resp = jsonify(jsonRecords)

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/products', methods=['POST'])
def createProduct():
    try:
        jsonData = request.json

        nombre = jsonData['nombre']
        categoria = jsonData['categoria']
        precio = jsonData['precio']
        imagen = jsonData['imagen']
        descripcion = jsonData['descripcion']

        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('insertar_producto', (nombre, categoria, precio, imagen, descripcion))
        conn.commit()

        resp = jsonify('Product added successfully!')
        resp.status_code = 200

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/products/<id>', methods=['PUT'])
def updateProduct(id):
    try:
        jsonData = request.json

        nombre = jsonData['nombre']
        categoria = jsonData['categoria']
        precio = jsonData['precio']
        imagen = jsonData['imagen']
        descripcion = jsonData['descripcion']

        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('update_product', (id, nombre, categoria, precio, imagen, descripcion))
        conn.commit()

        resp = jsonify('Product updated successfully!')
        resp.status_code = 200

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/products/<id>', methods=['DELETE'])
def deleteProduct(id):
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('delete_product', (id))
        conn.commit()

        resp = jsonify('Product deleted successfully!')
        resp.status_code = 200

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/platillos', methods=['GET'])
def getPlatillos():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('mostrar_platillos')
        row_headers = [x[0] for x in cursor.description]
        rows = cursor.fetchall()

        jsonData = []

        for result in rows:
            jsonData.append(dict(zip(row_headers, result)))

        resp = jsonify(jsonData)

        return resp
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

@app.route('/push', methods=['POST'])
def pushNotification():
    push_service = FCMNotification(api_key="AAAAuQBCBPE:APA91bGKiYJ_hPLifHUJebsjMSjlLUvjkoLpYcTCPDTkgHy7hwlOR6rSa0w3CFrfG7qg8p-p9jerFNoQT5G5DKMMyBz8JvJ4rzK0xGv_VCdCyHKWnbY3B0PLCj4TQlP7t_7S9IwABEum")

    jsonData = request.json

    cliente = jsonData['cliente']
    pedido = jsonData['pedido']
    cantidad = jsonData['cantidad']
    telefono = jsonData['telefono']
    colonia = jsonData['colonia']
    calle = jsonData['calle']
    numero = jsonData['numero']

    dataPayLoad = {
        "cliente": cliente,
        "pedido": pedido,
        "cantidad": cantidad,
        "telefono": telefono,
        "colonia": colonia,
        "calle": calle,
        "numero": numero,
    }

    message_title = "Pedido"
    message_body = "Nuevo pedido realizado"
    result = push_service.notify_topic_subscribers(topic_name="restaurant_topic", message_title=message_title, message_body=message_body, click_action='FLUTTER_NOTIFICATION_CLICK', data_message=dataPayLoad)

    return result

if __name__ == '__main__':
    app.run()