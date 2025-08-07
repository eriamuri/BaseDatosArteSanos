from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

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
            clientes = obtener_registros(con, "CLIENTE")
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
                input("Acepta Términos (1 o 0): ")
            )
            columnas = ['cedula', 'nombres', 'apellidos', 'correoElectronico', 'telefono', 'ubicacion', 'aceptaTermino']
            insertar_registro(con, "CLIENTE", columnas, datos)
        elif op == "3":
            cedula = input("Cédula del cliente: ")
            nuevo_correo = input("Nuevo correo: ")
            actualizar_registro(con, "CLIENTE", ["correoElectronico"], [nuevo_correo], "cedula", cedula)
        elif op == "4":
            cedula = input("Cédula del cliente a eliminar: ")
            eliminar_registro(con, "CLIENTE", "cedula", cedula)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
