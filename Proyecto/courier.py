from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

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
                input("ID Courier: "),
                input("Nombres: "),
                input("Apellidos: "),
                int(input("Cantidad Envíos: ")),
                input("Código Empresa: ")
            )
            columnas = ['courierID', 'nombres', 'apellidos', 'cantidadEnvios', 'codigoEmpresa']
            insertar_registro(con, "COURIER", columnas, datos)
        elif op == "3":
            id_courier = input("ID del courier a actualizar: ")
            datos = (
                input("Nombres: "),
                input("Apellidos: "),
                int(input("Cantidad Envíos: ")),
                input("Código Empresa: ")
            )
            columnas = ['nombres', 'apellidos', 'cantidadEnvios', 'codigoEmpresa']
            actualizar_registro(con, "COURIER", columnas, datos, "courierID", id_courier)
        elif op == "4":
            id_courier = input("ID del courier a eliminar: ")
            eliminar_registro(con, "COURIER", "courierID", id_courier)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
