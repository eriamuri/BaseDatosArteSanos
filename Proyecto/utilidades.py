def ejecutar_consulta(conexion, query, parametros=None, es_select=False):
    cursor = conexion.cursor()
    try:
        cursor.execute(query, parametros if parametros else ())
        if es_select:
            return cursor.fetchall()
        else:
            conexion.commit()
            return cursor.rowcount
    except Exception as error:
        print("Error en la consulta:", error)
        return None

def insertar_registro(con, tabla, columnas, valores):
    placeholders = ", ".join(["%s"] * len(valores))
    sql = f"INSERT INTO {tabla} ({', '.join(columnas)}) VALUES ({placeholders})"
    return ejecutar_consulta(con, sql, valores)

def obtener_registros(con, tabla):
    sql = f"SELECT * FROM {tabla}"
    return ejecutar_consulta(con, sql, es_select=True)

def actualizar_registro(con, tabla, columnas, valores, condicion_col, condicion_valor):
    set_clause = ", ".join([f"{col} = %s" for col in columnas])
    sql = f"UPDATE {tabla} SET {set_clause} WHERE {condicion_col} = %s"
    return ejecutar_consulta(con, sql, valores + [condicion_valor])

def eliminar_registro(con, tabla, condicion_col, condicion_valor):
    sql = f"DELETE FROM {tabla} WHERE {condicion_col} = %s"
    return ejecutar_consulta(con, sql, (condicion_valor,))
