from utilidades import llamar_sp, obtener_registros

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
            llamar_sp(con, "sp_admin_insert", datos)
        elif op == "3":
            id_admin = int(input("ID del administrador: "))
            nuevo_correo = input("Nuevo correo: ")
            llamar_sp(con, "sp_admin_update_correo", (id_admin, nuevo_correo))
        elif op == "4":
            id_admin = int(input("ID del administrador a eliminar: "))
            llamar_sp(con, "sp_admin_delete", (id_admin,))
        elif op == "0":
            break
        else:
            print("Opción inválida.")