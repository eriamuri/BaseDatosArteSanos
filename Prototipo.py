import mysql.connector

# Conexión a la base de datos
def conectar():
    try:
        conexion = mysql.connector.connect(
            host="localhost",     
            user="root",          
            password="",          
            database="proyectob"  
        )
        print("Conexión exitosa a la base de datos.")
        return conexion
    except mysql.connector.Error as error:
        print("Error al conectar a la base de datos:", error)
        return None

# Mostrar todos los clientes
def mostrar_clientes(conexion):
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM CLIENTE;")
    resultados = cursor.fetchall()
    print("\n📋 Clientes Registrados:")
    for cliente in resultados:
        print(cliente)

# Insertar un nuevo cliente
def registrar_cliente(conexion):
    cursor = conexion.cursor()
    nombre = input("Nombre: ")
    apellido = input("Apellido: ")
    cedula = input("Cédula: ")
    correo = input("Correo electrónico: ")
    telefono = input("Teléfono: ")

    try:
        cursor.execute("""
            INSERT INTO CLIENTE (nombre, apellido, cedula, correo, telefono)
            VALUES (%s, %s, %s, %s, %s);
        """, (nombre, apellido, cedula, correo, telefono))
        conexion.commit()
        print("Cliente registrado exitosamente.")
    except mysql.connector.Error as error:
        print("Error al registrar el cliente:", error)

# Menú principal
def menu():
    conexion = conectar()
    if not conexion:
        return

    while True:
        print("\n--- MENÚ PRINCIPAL ---")
        print("1. Ver clientes")
        print("2. Registrar nuevo cliente")
        print("3. Salir")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            mostrar_clientes(conexion)
        elif opcion == "2":
            registrar_cliente(conexion)
        elif opcion == "3":
            print("Gracias por usar el sistema.")
            conexion.close()
            break
        else:
            print("Opción inválida. Intente de nuevo.")

# Iniciar el programa
if __name__ == "__main__":
    menu()
