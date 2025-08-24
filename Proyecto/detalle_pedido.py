from utilidades import llamar_sp, obtener_registros

def menu_detalle_pedido(con):
    while True:
        print("\n--- DETALLE DE TRANSACCIÓN (CARRITO) ---")
        print("1. Ver Detalles de Transacciones")
        print("2. Añadir Producto a Transacción")
        print("3. Actualizar Cantidad de Producto")
        print("4. Quitar Producto de Transacción")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            detalles = obtener_registros(con, "DETALLES_PXT")
            for d in detalles:
                print(d)
        elif op == "2":

            datos = (
                int(input("ID Transacción: ")),
                int(input("ID Producto: ")),
                int(input("Cantidad: "))
            )
            llamar_sp(con, "sp_detalle_agregar", datos)
        elif op == "3":

            datos = (
                int(input("ID Transacción: ")),
                int(input("ID Producto a actualizar: ")),
                int(input("Nueva Cantidad: "))
            )
            llamar_sp(con, "sp_detalle_update_cantidad", datos)
        elif op == "4":
  
            datos = (
                int(input("ID Transacción: ")),
                int(input("ID Producto a eliminar: "))
            )
            llamar_sp(con, "sp_detalle_eliminar", datos)
        elif op == "0":
            break
        else:
            print("Opción inválida.")