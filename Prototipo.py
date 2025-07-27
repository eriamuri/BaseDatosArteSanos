print("----Bienvenido a tu programa: Artes Sanos----")

# Base de datos inicial, ahora con diccionarios anidados para cada usuario
# Esto permite almacenar la información con claves (ej: 'nombre', 'ruc', 'tipo')
baseDato = {
    "arte1@gmail.com": {
        "tipo": "Artesano",
        "nombre": "pedro",
        "apellido": "vera",
        "identificacion": "056231",  # Usaremos 'identificacion' para RUC/cedula
        "email": "arte1@gmail.com",
        "telefono": "0989868320"
    },
    "clie1@gmail.com": {
        "tipo": "Cliente",
        "nombre": "ivan",
        "apellido": "arias",
        "identificacion": "098685",  # Usaremos 'identificacion' para RUC/cedula
        "email": "clie1@gmail.com",
        "telefono": "0961125580"
    }
}

#Menus para los diferentes usuarios

def menu_artesano(usuario):
    while True:
        print("\n--- Menú del Artesano ---")
        print("1. Ver mi información")
        print("2. Actualizar mi número telefónico")
        print("3. Actualizar mi correo electrónico")
        print("4. Ver productos")
        print("5. Ver ventas")
        print("6. Cerrar sesión")
        opcion = input("Elija una opción: ")
        print("")

        if opcion == "1":
            for k, v in usuario.items():
                print(f"{k.replace('identificacion', 'RUC/Cédula').capitalize()}: {v}")
        elif opcion == "2":
            usuario["telefono"] = input("Nuevo teléfono: ")
            print("¡Teléfono actualizado!")
        elif opcion == "3":
            nuevo_email = input("Nuevo correo electrónico: ")
            if nuevo_email in baseDato and nuevo_email != usuario["email"]:
                print("Ese correo ya está en uso.")
            else:
                baseDato[nuevo_email] = usuario
                baseDato[nuevo_email]["email"] = nuevo_email
                del baseDato[usuario["email"]]
                usuario["email"] = nuevo_email
                print("Correo actualizado exitosamente.")
        elif opcion == "4":
            print("\n--- Productos disponibles ---")
            print("1. Collar de plata - $25.00")
            print("2. Pulsera de cuero - $15.00")
            print("3. Cerámica pintada a mano - $40.00")
        elif opcion == "5":
            print("\n--- Ventas recientes ---")
            print("Venta: 2 collares vendidos.")
            print("Total: $50.75")
            print("Comprador: Mateo Romanof")
            print("Estado: Enviado")
        elif opcion == "6":
            print("Sesión cerrada. ¡Hasta luego!")
            break
        else:
            print("Opción inválida.")

def menu_cliente(usuario):
    while True:
        print("\n--- Menú del Cliente ---")
        print("1. Ver mi información")
        print("2. Actualizar mi número telefónico")
        print("3. Actualizar mi correo electrónico")
        print("4. Cerrar sesión")
        opcion = input("Elija una opción: ")
        print("")

        if opcion == "1":
            for k, v in usuario.items():
                print(f"{k.replace('identificacion', 'RUC/Cédula').capitalize()}: {v}")
        elif opcion == "2":
            usuario["telefono"] = input("Nuevo teléfono: ")
            print("¡Teléfono actualizado!")
        elif opcion == "3":
            nuevo_email = input("Nuevo correo electrónico: ")
            if nuevo_email in baseDato and nuevo_email != usuario["email"]:
                print("Ese correo ya está en uso.")
            else:
                baseDato[nuevo_email] = usuario
                baseDato[nuevo_email]["email"] = nuevo_email
                del baseDato[usuario["email"]]
                usuario["email"] = nuevo_email
                print("Correo actualizado exitosamente.")
        elif opcion == "4":
            print("Sesión cerrada. ¡Hasta luego!")
            break
        else:
            print("Opción inválida.")


#Programa Principal

while True:
    print("\n--- Menú Principal ---")
    valor1 = input("¿Desea registrarse (1), ingresar al sistema (2) o salir (3)?: ")

    if valor1 == "1":
        print("\n----Registro----")
        valor2 = input("¿Registrarse como Artesano (1) o Cliente (2)?: ")

        if valor2 == "1":
            narte = input("Nombre: ")
            aarte = input("Apellido: ")
            carte = input("RUC (será su contraseña): ")
            cearte = input("Correo electrónico: ")
            tarte = input("Teléfono: ")

            if cearte in baseDato:
                print("¡Error! Correo ya registrado.")
            else:
                baseDato[cearte] = {
                    "tipo": "Artesano",
                    "nombre": narte,
                    "apellido": aarte,
                    "identificacion": carte,
                    "email": cearte,
                    "telefono": tarte
                }
                print("¡Registro exitoso como Artesano!")
        elif valor2 == "2":
            nclie = input("Nombre: ")
            aclie = input("Apellido: ")
            cclie = input("Cédula (será su contraseña): ")
            ceclie = input("Correo electrónico: ")
            tclie = input("Teléfono: ")

            if ceclie in baseDato:
                print("¡Error! Correo ya registrado.")
            else:
                baseDato[ceclie] = {
                    "tipo": "Cliente",
                    "nombre": nclie,
                    "apellido": aclie,
                    "identificacion": cclie,
                    "email": ceclie,
                    "telefono": tclie
                }
                print("¡Registro exitoso como Cliente!")
        else:
            print("Opción inválida.")

    elif valor1 == "2":
        print("\n----Ingreso----")
        correo_ingresado = input("Correo electrónico: ")
        contra_ingresada = input("Contraseña (RUC/Cédula): ")

        if correo_ingresado in baseDato:
            usuario = baseDato[correo_ingresado]
            if usuario["identificacion"] == contra_ingresada:
                print(f"\n¡Ingreso exitoso! Bienvenido/a {usuario['nombre']} ({usuario['tipo']})")
                if usuario["tipo"] == "Artesano":
                    menu_artesano(usuario)
                else:
                    menu_cliente(usuario)
            else:
                print("Contraseña incorrecta.")
        else:
            print("Correo no registrado.")
    elif valor1 == "3":
        print("Gracias por usar el sistema. ¡Hasta luego!")
        break
    else:
        print("Opción inválida.")
    
