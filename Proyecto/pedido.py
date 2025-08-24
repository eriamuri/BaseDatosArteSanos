from utilidades import llamar_sp, obtener_registros

def menu_pedido(con):
    while True:
        print("\n--- PEDIDOS ---")
        print("1. Ver Pedidos (Tracking de Courier)")
        print("2. Registrar Pedido")
        print("3. Actualizar Fecha de Pedido")
        print("4. Eliminar Pedido")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":

            pedidos = obtener_registros(con, "vw_pedidos_courier_tracking")
            for ped in pedidos:
                print(ped)
        elif op == "2":

            datos = (
                int(input("ID de la Transacción asociada: ")),
                int(input("ID del Courier asignado: ")),
                input("Dirección de Destino: "),
                input("Fecha de Evento (YYYY-MM-DD): ")
            )
            llamar_sp(con, "sp_pedido_crear", datos)
        elif op == "3":
            id_pedido = int(input("ID del pedido: "))
            nueva_fecha = input("Nueva fecha de evento (YYYY-MM-DD): ")
            llamar_sp(con, "sp_pedido_update_fecha", (id_pedido, nueva_fecha))
        elif op == "4":
            id_pedido = int(input("ID del pedido a eliminar: "))
            llamar_sp(con, "sp_pedido_delete", (id_pedido,))
        elif op == "0":
            break
        else:
            print("Opción inválida.")