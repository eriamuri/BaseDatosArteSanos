import mysql.connector

def conectar():
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="proyectob"
        )
        print(" Conexión exitosa a la base de datos.")
        return conexion
    except mysql.connector.Error as error:
        print(" Error al conectar a la base de datos:", error)
        return None

def mostrar_clientes(conexion):
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM CLIENTE;")
    resultados = cursor.fetchall()
    print("\n📋 Clientes Registrados:")
    for cliente in resultados:
        cedula, nombres, apellidos, correo, telefono, ubicacion, acepta = cliente
        print(f"Cédula: {cedula}, Nombre: {nombres} {apellidos}, Correo: {correo}, Teléfono: {telefono}, Ubicación: {ubicacion}, Acepta Términos: {acepta}")

def mostrar_administradores(conexion):
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM ADMINISTRADOR;")
    resultados = cursor.fetchall()
    print("\n📋 Administradores Registrados:")
    for admin in resultados:
        adminID, nombres, apellidos, correo = admin
        print(f"ID: {adminID}, Nombre: {nombres} {apellidos}, Correo: {correo}")

def registrar_cliente(conexion):
    cursor = conexion.cursor()
    cedula = input("Cédula: ")
    nombres = input("Nombres: ")
    apellidos = input("Apellidos: ")
    correo = input("Correo electrónico: ")
    telefono = input("Teléfono: ")
    ubicacion = input("Ubicación: ")
    acepta_terminos = input("Acepta términos? (sí/no): ").strip().lower()
    acepta = True if acepta_terminos in ['sí', 'si', 's', 'yes'] else False

    try:
        cursor.execute("""
            INSERT INTO CLIENTE (cedula, nombres, apellidos, correoElectronico, telefono, ubicacion, aceptaTermino)
            VALUES (%s, %s, %s, %s, %s, %s, %s);
        """, (cedula, nombres, apellidos, correo, telefono, ubicacion, acepta))
        conexion.commit()
        print(" Cliente registrado exitosamente.")
    except mysql.connector.Error as error:
        print(" Error al registrar el cliente:", error)

def registrar_administrador(conexion):
    cursor = conexion.cursor()
    nombres = input("Nombres: ")
    apellidos = input("Apellidos: ")
    correo = input("Correo electrónico: ")

    try:
        cursor.execute("""
            INSERT INTO ADMINISTRADOR (nombres, apellidos, correoElectronico)
            VALUES (%s, %s, %s);
        """, (nombres, apellidos, correo))
        conexion.commit()
        print(" Administrador registrado exitosamente.")
    except mysql.connector.Error as error:
        print(" Error al registrar el administrador:", error)

def menu():
    conexion = conectar()
    if not conexion:
        return

    while True:
        print("\n--- MENÚ PRINCIPAL ---")
        print("1. Ver clientes")
        print("2. Ver administradores")
        print("3. Registrar nuevo cliente")
        print("4. Registrar nuevo administrador")
        print("5. Salir")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            mostrar_clientes(conexion)
        elif opcion == "2":
            mostrar_administradores(conexion)
        elif opcion == "3":
            registrar_cliente(conexion)
        elif opcion == "4":
            registrar_administrador(conexion)
        elif opcion == "5":
            print(" Gracias por usar el sistema.")
            conexion.close()
            break
        else:
            print(" Opción inválida. Intente de nuevo.")

if __name__ == "__main__":
    menu()
