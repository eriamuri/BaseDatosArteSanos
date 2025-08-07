from conexion import conectar
from cliente import menu_cliente
from administrador import menu_administrador
from producto import menu_producto
from pedido import menu_pedido
from detalle_pedido import menu_detalle_pedido
from courier import menu_courier
from soporte import menu_soporte
from transaccion import menu_transaccion

def menu_principal():
    con = conectar()
    if not con:
        return

    while True:
        print("\n--- MENÚ PRINCIPAL ---")
        print("1.  Clientes")
        print("2.  Administradores")
        print("3.  Productos")
        print("4.  Pedidos")
        print("5.  Detalles Pedido")
        print("6.  Couriers")
        print("7.  Soportes")
        print("8.  Transacciones")
        print("0. Salir")
        op = input("Seleccione una opción: ")

        if op == "1":
            menu_cliente(con)
        elif op == "2":
            menu_administrador(con)
        elif op == "3":
            menu_producto(con)
        elif op == "4":
            menu_pedido(con)
        elif op == "5":
            menu_detalle_pedido(con)
        elif op == "6":
            menu_courier(con)
        elif op == "7":
            menu_soporte(con)
        elif op == "8":
            menu_transaccion(con)
        elif op == "0":
            con.close()
            print("Hasta luego.")
            break
        else:
            print("Opción inválida.")

if __name__ == "__main__":
    menu_principal()
