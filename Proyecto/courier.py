from utilidades import llamar_sp, obtener_registros

def menu_courier(con):
    while True:
        print("\n--- COURIERS ---")
        print("1. Ver Couriers")
        print("2. Registrar Courier")
        print("3. Actualizar Courier")
        print("4. Eliminar Courier")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            couriers = obtener_registros(con, "COURIER")
            for c in couriers:
                print(c)
        elif op == "2":
            datos = (
                input("Nombres: "),
                input("Apellidos: "),
                int(input("Cantidad Envíos: ")),
                input("Código Empresa: ")
            )
            llamar_sp(con, "sp_courier_insert", datos)
        elif op == "3":
            id_courier = int(input("ID del courier a actualizar: "))
            datos = (
                id_courier,
                input("Nuevos Nombres: "),
                input("Nuevos Apellidos: "),
                int(input("Nueva Cantidad Envíos: ")),
                input("Nuevo Código Empresa: ")
            )
            llamar_sp(con, "sp_courier_update", datos)
        elif op == "4":
            id_courier = int(input("ID del courier a eliminar: "))
            llamar_sp(con, "sp_courier_delete", (id_courier,))
        elif op == "0":
            break
        else:
            print("Opción inválida.")