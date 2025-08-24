from utilidades import llamar_sp, obtener_registros

def menu_transaccion(con):
    while True:
        print("\n--- TRANSACCIONES ---")
        print("1. Ver Transacciones")
        print("2. Crear Nueva Transacción (Pendiente)")
        print("3. Actualizar Estado de Transacción")
        print("4. Eliminar Transacción")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            transacciones = obtener_registros(con, "TRANSACCION")
            for t in transacciones:
                print(t)
        elif op == "2":
       
            id_cliente = input("Cédula del Cliente para la transacción: ")
      
            llamar_sp(con, "sp_transaccion_crear", (id_cliente,))
        elif op == "3":
    
            id_transaccion = int(input("ID de la transacción a actualizar: "))
            nuevo_estado = input("Nuevo estado (COMPLETADA, CANCELADA, etc.): ")
  
            print("NOTA: Se requiere un SP específico para actualizar solo el estado.")
        elif op == "4":
            id_transaccion = int(input("ID de la transacción a eliminar: "))
            print("NOTA: Se requiere un SP específico para eliminar transacciones.")
        elif op == "0":
            break
        else:
            print("Opción inválida.")