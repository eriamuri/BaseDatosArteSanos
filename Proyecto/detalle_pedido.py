from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

def menu_detalle_pedido(con):
    while True:
        print("\n--- DETALLE PEDIDO ---")
        print("1. Ver Detalles de Pedido")
        print("2. Registrar Detalle de Pedido")
        print("3. Actualizar Detalle de Pedido")
        print("4. Eliminar Detalle de Pedido")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            detalles = obtener_registros(con, "DETALLE_PEDIDO")
            for d in detalles:
                print(d)
        elif op == "2":
            datos = (
                input("ID Pedido: "),
                input("ID Producto: "),
                int(input("Cantidad: "))
            )
            columnas = ['pedidoID', 'productoID', 'cantidad']
            insertar_registro(con, "DETALLE_PEDIDO", columnas, datos)
        elif op == "3":
            id_detalle = input("ID detalle a actualizar: ")
            datos = (
                input("ID Pedido: "),
                input("ID Producto: "),
                int(input("Nueva Cantidad: "))
            )
            columnas = ['pedidoID', 'productoID', 'cantidad']
            actualizar_registro(con, "DETALLE_PEDIDO", columnas, datos, "detalleID", id_detalle)
        elif op == "4":
            id_detalle = input("ID detalle a eliminar: ")
            eliminar_registro(con, "DETALLE_PEDIDO", "detalleID", id_detalle)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
