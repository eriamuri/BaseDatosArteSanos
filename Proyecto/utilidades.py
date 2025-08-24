import mysql.connector

def llamar_sp(conexion, nombre_sp, args=()):

    try:
        cursor = conexion.cursor()
        cursor.callproc(nombre_sp, args)
        conexion.commit()
        print(f"✅ Operación '{nombre_sp}' ejecutada exitosamente.")
        cursor.close()
        return True
    except mysql.connector.Error as error:
        # Los errores con SQLSTATE '45000' son validaciones personalizadas desde el SP
        if error.sqlstate == '45000':
            print(f"❌ Error de validación: {error.msg}")
        else:
            print(f"❌ Error de base de datos: {error}")
        return False

def obtener_registros(con, tabla_o_vista):

    cursor = con.cursor()
    try:
        # Usamos .format() de forma segura aquí porque el nombre de la tabla no viene del usuario
        sql = f"SELECT * FROM {tabla_o_vista}"
        cursor.execute(sql)
        return cursor.fetchall()
    except mysql.connector.Error as error:
        print("Error en la consulta:", error)
        return []
    finally:
        cursor.close()

