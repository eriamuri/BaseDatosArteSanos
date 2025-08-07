from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

def menu_administrador(con):
    while True:
        print("\n--- ADMINISTRADORES ---")
        print("1. Ver Administradores")
        print("2. Registrar Administrador")
        print("3. Actualizar Correo")
        print("4. Eliminar Administrador")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            admins = obtener_registros(con, "ADMINISTRADOR")
            for a in admins:
                print(a)
        elif op == "2":
            datos = (
                input("Nombres: "),
                input("Apellidos: "),
                input("Correo: ")
            )
            columnas = ['nombres', 'apellidos', 'correoElectronico']
            insertar_registro(con, "ADMINISTRADOR", columnas, datos)
        elif op == "3":
            id_admin = input("ID del administrador: ")
            nuevo_correo = input("Nuevo correo: ")
            actualizar_registro(con, "ADMINISTRADOR", ["correoElectronico"], [nuevo_correo], "administradorID", id_admin)
        elif op == "4":
            id_admin = input("ID del administrador a eliminar: ")
            eliminar_registro(con, "ADMINISTRADOR", "administradorID", id_admin)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
