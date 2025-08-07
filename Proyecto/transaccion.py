from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

def menu_transaccion(con):
    while True:
        print("\n--- TRANSACCIONES ---")
        print("1. Ver Transacciones")
        print("2. Registrar Transacción")
        print("3. Actualizar Transacción")
        print("4. Eliminar Transacción")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            transacciones = obtener_registros(con, "TRANSACCION")
            for t in transacciones:
                print(t)
        elif op == "2":
            datos = (
                input("ID Transacción: "),
                input("Fecha (YYYY-MM-DD): "),
                input("Método de Pago: "),
                float(input("Total: ")),
                input("Cédula Cliente: ")
            )
            columnas = ['transaccionID', 'fecha', 'metodoPago', 'total', 'cedulaCliente']
            insertar_registro(con, "TRANSACCION", columnas, datos)
        elif op == "3":
            id_transaccion = input("ID de la transacción a actualizar: ")
            datos = (
                input("Fecha (YYYY-MM-DD): "),
                input("Método de Pago: "),
                float(input("Total: ")),
                input("Cédula Cliente: ")
            )
            columnas = ['fecha', 'metodoPago', 'total', 'cedulaCliente']
            actualizar_registro(con, "TRANSACCION", columnas, datos, "transaccionID", id_transaccion)
        elif op == "4":
            id_transaccion = input("ID de la transacción a eliminar: ")
            eliminar_registro(con, "TRANSACCION", "transaccionID", id_transaccion)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
