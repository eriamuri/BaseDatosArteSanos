from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

def menu_soporte(con):
    while True:
        print("\n--- SOPORTES ---")
        print("1. Ver Soportes")
        print("2. Registrar Soporte")
        print("3. Actualizar Soporte")
        print("4. Eliminar Soporte")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            soportes = obtener_registros(con, "SOPORTE")
            for s in soportes:
                print(s)
        elif op == "2":
            datos = (
                input("ID Soporte: "),
                input("Correo Electrónico: "),
                input("ID Administrador: ")
            )
            columnas = ['soporteID', 'correoElectronico', 'administradorID']
            insertar_registro(con, "SOPORTE", columnas, datos)
        elif op == "3":
            id_soporte = input("ID del soporte a actualizar: ")
            datos = (
                input("Correo Electrónico: "),
                input("ID Administrador: ")
            )
            columnas = ['correoElectronico', 'administradorID']
            actualizar_registro(con, "SOPORTE", columnas, datos, "soporteID", id_soporte)
        elif op == "4":
            id_soporte = input("ID del soporte a eliminar: ")
            eliminar_registro(con, "SOPORTE", "soporteID", id_soporte)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
