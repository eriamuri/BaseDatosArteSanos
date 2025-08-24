from utilidades import llamar_sp, obtener_registros

def menu_cliente(con):
    while True:
        print("\n--- CLIENTES ---")
        print("1. Ver Clientes")
        print("2. Registrar Cliente")
        print("3. Actualizar Correo")
        print("4. Eliminar Cliente")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
           
            clientes = obtener_registros(con, "vw_ventas_por_cliente_detalle")
            print("\n--- Reporte de Ventas por Cliente ---")
            for c in clientes:
                print(c)
        elif op == "2":
            datos = (
                input("Cédula: "),
                input("Nombres: "),
                input("Apellidos: "),
                input("Correo: "),
                input("Teléfono: "),
                input("Ubicación: "),
                int(input("Acepta Términos (1 o 0): "))
            )
            llamar_sp(con, "sp_cliente_insert", datos)
        elif op == "3":
            cedula = input("Cédula del cliente: ")
            nuevo_correo = input("Nuevo correo: ")
            llamar_sp(con, "sp_cliente_update_correo", (cedula, nuevo_correo))
        elif op == "4":
            cedula = input("Cédula del cliente a eliminar: ")
            llamar_sp(con, "sp_cliente_delete", (cedula,))
        elif op == "0":
            break
        else:
            print("Opción inválida.")
