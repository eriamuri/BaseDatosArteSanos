from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

def menu_pedido(con):
    while True:
        print("\n--- PEDIDOS ---")
        print("1. Ver Pedidos")
        print("2. Registrar Pedido")
        print("3. Actualizar Pedido")
        print("4. Eliminar Pedido")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            pedidos = obtener_registros(con, "PEDIDO")
            for ped in pedidos:
                print(ped)
        elif op == "2":
            datos = (
                input("Cédula Cliente: "),
                input("Fecha (YYYY-MM-DD): ")
            )
            columnas = ['cedulaCliente', 'fechaPedido']
            insertar_registro(con, "PEDIDO", columnas, datos)
        elif op == "3":
            id_pedido = input("ID del pedido: ")
            nueva_fecha = input("Nueva fecha (YYYY-MM-DD): ")
            actualizar_registro(con, "PEDIDO", ['fechaPedido'], [nueva_fecha], "pedidoID", id_pedido)
        elif op == "4":
            id_pedido = input("ID del pedido a eliminar: ")
            eliminar_registro(con, "PEDIDO", "pedidoID", id_pedido)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
