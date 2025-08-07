from utilidades import insertar_registro, obtener_registros, actualizar_registro, eliminar_registro

def menu_producto(con):
    while True:
        print("\n--- PRODUCTOS ---")
        print("1. Ver Productos")
        print("2. Registrar Producto")
        print("3. Actualizar Producto")
        print("4. Eliminar Producto")
        print("0. Volver")
        op = input("Seleccione una opción: ")

        if op == "1":
            productos = obtener_registros(con, "PRODUCTO")
            for p in productos:
                print(p)
        elif op == "2":
            datos = (
                input("Nombre: "),
                input("Descripción: "),
                float(input("Precio: ")),
                int(input("Stock: ")),
                input("Cédula Artesano: ")
            )
            columnas = ['nombre', 'descripcion', 'precio', 'stock', 'cedulaArtesano']
            insertar_registro(con, "PRODUCTO", columnas, datos)
        elif op == "3":
            id_prod = input("ID del producto: ")
            datos = (
                input("Nombre: "),
                input("Descripción: "),
                float(input("Precio: ")),
                int(input("Stock: ")),
                input("Cédula Artesano: ")
            )
            columnas = ['nombre', 'descripcion', 'precio', 'stock', 'cedulaArtesano']
            actualizar_registro(con, "PRODUCTO", columnas, datos, "productoID", id_prod)
        elif op == "4":
            id_prod = input("ID del producto a eliminar: ")
            eliminar_registro(con, "PRODUCTO", "productoID", id_prod)
        elif op == "0":
            break
        else:
            print("Opción inválida.")
