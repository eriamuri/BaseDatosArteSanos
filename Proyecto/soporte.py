from utilidades import llamar_sp, obtener_registros

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
                input("Correo Electrónico: "),
                int(input("ID Administrador asignado: "))
            )
            llamar_sp(con, "sp_soporte_insert", datos)
        elif op == "3":
            id_soporte = int(input("ID del soporte a actualizar: "))
            datos = (
                id_soporte,
                input("Nuevo Correo Electrónico: "),
                int(input("Nuevo ID Administrador: "))
            )
            llamar_sp(con, "sp_soporte_update", datos)
        elif op == "4":
            id_soporte = int(input("ID del soporte a eliminar: "))
            llamar_sp(con, "sp_soporte_delete", (id_soporte,))
        elif op == "0":
            break
        else:
            print("Opción inválida.")