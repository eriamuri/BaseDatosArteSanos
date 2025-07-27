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

while True:
    print("\n--- Menú Principal ---")
    valor1 = input("¿Desea registrarse (1) o ingresar al sistema (2)? (Para salir ingrese (3)): ")

    if valor1 == "1":
        print("\n----Proceso de Registro----")
        valor2 = input("¿Desea registrarse como Artesano (1) o como Cliente (2)?: ")

        if valor2 == "1": # Registro de Artesano
            narte = input("Ingrese su nombre: ")
            aarte = input("Ingrese su apellido: ")
            carte = input("Ingrese su RUC (será su contraseña): ") # Contraseña es el RUC
            cearte = input("Ingrese su correo electrónico: ")
            tarte = input("Ingrese su número telefónico: ")

            if cearte in baseDato:
                print("¡Error! Ya existe un usuario (Artesano o Cliente) registrado con este correo electrónico.")
            else:
                baseDato[cearte] = {
                    "tipo": "Artesano",
                    "nombre": narte,
                    "apellido": aarte,
                    "identificacion": carte, # Guarda el RUC como identificacion
                    "email": cearte,
                    "telefono": tarte
                }
                print("\n----Registro de Artesano Exitoso!!----")
        elif valor2 == "2": # Registro de Cliente
            nclie = input("Ingrese su nombre: ")
            aclie = input("Ingrese su apellido: ")
            cclie = input("Ingrese su cédula (será su contraseña): ") # Contraseña es la cédula
            ceclie = input("Ingrese su correo electrónico: ")
            tclie = input("Ingrese su número telefónico: ")

            if ceclie in baseDato:
                print("¡Error! Ya existe un usuario (Artesano o Cliente) registrado con este correo electrónico.")
            else:
                baseDato[ceclie] = {
                    "tipo": "Cliente",
                    "nombre": nclie,
                    "apellido": aclie,
                    "identificacion": cclie, # Guarda la cédula como identificacion
                    "email": ceclie,
                    "telefono": tclie
                }
                print("\n----Registro de Cliente Exitoso!!----")
        else:
            print("Opción inválida. Por favor, ingrese 1 para Artesano o 2 para Cliente.")

    elif valor1 == "2": # Proceso de Ingreso
        print("\n----Proceso de Ingreso----")
        correo_ingresado = input("Ingrese su correo electrónico: ")
        contra_ingresada = input("Ingrese su contraseña (RUC o Cédula): ")

        if correo_ingresado in baseDato:
            usuario_registrado = baseDato[correo_ingresado]
            # Accedemos a la "identificacion" (RUC/cédula) guardada para verificar
            if usuario_registrado["identificacion"] == contra_ingresada:
                print(f"\n----¡Ingreso Exitoso! Bienvenido/a {usuario_registrado['nombre']} como {usuario_registrado['tipo']}----")
                
                
                while True:
                    print("\n--- Menú de Usuario ---")
                    print("1. Ver mi información")
                    print("2. Actualizar mi número telefónico")
                    print("3. Actualizar mi correo electrónico")
                    print("4. Ver productos (Solo para Artesanos)")
                    print("5. Ver ventas (Solo para Artesanos)")
                    print("6. Cerrar sesión")
                    opcion_usuario = input("¿Qué desea hacer?: ")

                    if opcion_usuario == "1":
                        print("\n--- Su Información ---")
                        for key, value in usuario_registrado.items():
                            print(f"{key.replace('identificacion', 'RUC/Cédula').capitalize()}: {value}")
                        print("--------------------")

                    elif opcion_usuario == "2":
                        nuevo_telefono = input("Ingrese su nuevo número telefónico: ")
                        usuario_registrado["telefono"] = nuevo_telefono
                        print("¡Número telefónico actualizado con éxito!")

                    elif opcion_usuario == "3":
                        nuevo_email = input("Ingrese su nuevo correo electrónico: ")
                        if nuevo_email in baseDato and nuevo_email != correo_ingresado:
                            print("¡Error! Este correo ya está registrado por otro usuario.")
                        else:
                            # Creamos una nueva entrada con el nuevo correo y eliminamos la vieja
                            baseDato[nuevo_email] = usuario_registrado
                            baseDato[nuevo_email]["email"] = nuevo_email # Actualizar el email dentro del diccionario
                            del baseDato[correo_ingresado] # Eliminamos la entrada antigua
                            correo_ingresado = nuevo_email # Actualizamos el correo_ingresado para futuras operaciones
                            print("¡Correo electrónico actualizado con éxito! Su nuevo usuario es:", nuevo_email)
                            
                    elif opcion_usuario == "4": 
                        if usuario_registrado["tipo"] == "Artesano":
                            print("\n--- Ver productos del artesano ---")
                            input("Presione Enter para ver sus productos...")
                            print("Mostrando productos...")
                            print("Producto 1: Collar de plata - Precio: $25.00")
                            print("Producto 2: Pulsera de cuero - Precio: $15.00")
                            print("Producto 3: Cerámica pintada a mano - Precio: $40.00")
                        else:
                            print("¡Acceso denegado! Esta opción es solo para Artesanos.")
                    
                    
                    elif opcion_usuario == "5": 
                        if usuario_registrado["tipo"] == "Artesano":
                            print("\n--- Ver ventas del artesano ---")
                            input("Presione Enter para ver sus ventas...")
                            venta_aleatoria = 50.75 # Valor de ejemplo
                            print(f"Su venta reciente fue de: ${venta_aleatoria:.2f}")
                            print("Detalle: 2 collares vendidos.")
                            print("comprador: Mateo Romanof")
                            print("estado: enviado")
                        else:
                            print("¡Acceso denegado! Esta opción es solo para Artesanos.")
                    
                    elif opcion_usuario == "6": # Cerrar sesión
                        print("Cerrando sesión. ¡Hasta pronto!")
                        break

                    else:
                        print("Opción inválida. Por favor, seleccione una opción válida.")
                
                
                
                
                
                # Aquí podrías añadir la lógica para llevar al usuario al menú principal de su tipo
            else:
                print("\n----Contraseña incorrecta. Por favor, intente de nuevo.----")
        else:
            print("\n----Correo electrónico no registrado. Por favor, regístrese o verifique su correo.----")
            
    elif valor1 == "3": # opción para salir
        print("Saliendo del sistema. ¡Hasta luego!")
        break 
    else:
        print("Opción inválida. Por favor, seleccione 1 para registrarse o 2 para ingresar.")
    
    

    
