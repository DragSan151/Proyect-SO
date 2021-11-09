#!/bin/bash
Alta(){
if [ -f Clientes.txt ]
then
sleep 0,02
else 
touch Clientes.txt
fi
echo Dar de alta a un cliente
read -p "Ingrese el nombre del cliente " NCliente
read -p "Ingrese el apellido del cliente " ACliente
read -p "Ingrese la cedula del cliente " CCliente

existeC=$(grep -c "$CCliente" Clientes.txt | cut -f 3 -d":" )

if [ "$existeC" -eq 0 ]
then
fecha=$( date +'%d/%m/%Y %H:%M' )
echo "$NCliente:$ACliente:$CCliente:$fecha" >> Clientes.txt
cat Clientes.txt
else
fecha=$( date +'%d/%m/%Y %H:%M' )
echo "Ingreso una cedula repetida $CCliente $fecha" >> log.txt
echo "No se puede ingresar a un cliente con una misma cedula que otro cliente"
fi
}

Baja() {
read -p "Ingrese la cedula del cliente " Cedula
CedulaIgual=$( grep "$Cedula" Clientes.txt | cut -f 3 -d":"  )
linea=$( grep "$Cedula" Clientes.txt  | cut -f 1 -d":" )

if [ "$CedulaIgual" == "$Cedula" ]
then
echo "Cliente Encontrado .... "
echo "Cliente dando de baja....."
sed -i  "/$linea/d" Clientes.txt
cat Clientes.txt
else
     echo "Cliente no encontrado "
fi
}

Modificar() {

opciones=4
clear
while [ "$opciones" != "0" ]
do


echo "Modificar datos"
echo "Que dato quieres modificar  "
echo "1)Nombre"
echo "2)Apellido"
echo "3)Fecha de ingreso"
echo "0)Salir"
echo "Ingrese la opcion "

read opciones

case $opciones in
1)
cat Clientes.txt
read -p "Ingrese la cedula del usuario a modificar " cedula
CedulaEq=$( grep "$cedula" Clientes.txt | cut -f 3 -d ":" )

if [ $cedula == $CedulaEq ]
then
Apellido=$( cut -f 2 -d":" Clientes.txt)
Fecha=$( cut -f 3 -d":" Clientes.txt)
read -p "Ingrese el nuevo nombre " NewName
sed -i /$cedula/c\ $NewName:$Apellido:$cedula:$Fecha Clientes.txt
else
fecha=$( date +'%d/%m/%Y %H:%M' )
echo "Error al ingresar la cedula en modificar datos $cedula $fecha" >> log.txt
echo "Error  al ingresar la cedula "
fi
;;

2)
cat Clientes.txt
read -p "Ingrese la cedula del usuario a modificar " cedula
CedulaEq=$( grep "$cedula" Clientes.txt | cut -f 3 -d ":" )

if [ $cedula == $CedulaEq ]
then
Nombre=$( cut -f 1 -d":" Clientes.txt)
Fecha=$( cut -f 3 -d":" Clientes.txt)
read -p "Ingrese el nuevo apellido " NewApe
sed -i /$cedula/c\ $Nombre:$NewApe:$cedula:$Fecha Clientes.txt
else
fecha=$( date +'%d/%m/%Y %H:%M' )
echo "Error al ingresar la cedula en modificar datos $cedula $fecha" >> log.txt
echo "Error  al ingresar la cedula "
fi
;;

3)
cat Clientes.txt
read -p "Ingrese la cedula del usuario a modificar " cedula
CedulaEq=$( grep "$cedula" Clientes.txt | cut -f 3 -d ":" )

if [ $cedula == $CedulaEq ]
then
Nombre=$( cut -f 1 -d":" Clientes.txt)
Apellido=$( cut -f 2 -d":" Clientes.txt)
fecha=$( date +'%d/%m/%Y %H:%M' )
sed -i /$cedula/c\ $Nombre:$Apellido:$cedula:$fecha Clientes.txt
else
fecha=$( date +'%d/%m/%Y %H:%M' )
echo "Error al ingresar la cedula en modificar datos $cedula $fecha" >> log.txt
echo "Error  al ingresar la cedula "
fi
;;

0)
echo "Has salido"
;;

*)
echo "Error en el ingreso"
;;
esac
done
}

Lista() {
if [ -f clientes.txt ]
then
cat Clientes.txt
echo "Hola"
else
touch clientes.txt
fi
}

Buscar() {

if [ -f Clientes.txt ]
then

opcion=4

while [ "$opcion" != "0"  ]
do

echo "Buscar datos de usuario"
echo "1)Buscar el nombre"
echo "2)Buscar el apellido"
echo "3)Buscar la fecha"
echo "0)Volver al menu"
read opcion
case $opcion in

1)
read -p "Ingrese la cedula para buscar el cliente " cedula

CedulaIgual=$( grep "$cedula" Clientes.txt | cut -f 3 -d":"  )

linea=$( grep "$cedula" Clientes.txt  | cut -f 1 -d":" )

if [ "$CedulaIgual" == "$cedula" ]
then
echo "$linea"
else
echo "No existe la cedula"
fi
;;

2)
read -p "Ingrese la cedula para buscar el cliente " cedula

CedulaIgual=$( grep "$cedula" Clientes.txt | cut -f 3 -d":"  )

linea=$( grep "$cedula" Clientes.txt  | cut -f 2 -d":" )

if [ $CedulaIgual == $cedula ]
then
echo "$linea"
else
echo "No existe la cedula"
fi
;;
3)
read -p "Ingrese la cedula para buscar el cliente " cedula

CedulaIgual=$( grep "$cedula" Clientes.txt | cut -f 3 -d":"  )

linea=$( grep "$cedula" Clientes.txt  | cut -f 4 -d":" )

if [ $CedulaIgual == $cedula ]
then
echo "$linea"
else
echo "No existe la cedula"
fi

;;
0)
echo "Has Salido"
;;
*)
echo "Error en el ingreso"
;;

esac
done

else
echo "El fichero no existe"
fecha=$( date +'%d/%m/%Y %H:%M' )
echo "No existe el fichero Usuario.txt $fecha" >> log.txt
fi
}

Logout() {
clear
./login.sh
}

op=-1

while [ "$op" != "0" ]
do
echo "-------------------------"
echo "Bienvenido administrativo"
echo "-------------------------"
echo "1) Dar de alta a un cliente     "
echo "2) Dar de baja a un cliente     "
echo "3) Modificar datos de un cliente"
echo "4) Listar un cliente            "
echo "5) Buscar un cliente            "
echo "0) Deslogearse                  "
read -p "Elija una opcion " op

case $op in

1)
clear
echo "Ingreso el alta de Clientes"
Alta
;;
2)
clear
echo "Ingreso la baja de Clientes"
Baja
;;
3)
clear
echo "Ingreso la modificacion de Clientes"
Modificar
;;
4)
clear
echo "Ingreso el listado de Clientes"
Lista
;;
5)
clear
echo "Ingreso la busqueda de Clientes"
Buscar
;;
0)
clear
echo "Ingreso la vuelta al login"
Logout
;;
*)
echo "!!!ERROR NUMERO FUERA DE RANGO ERROR!!!"
;;
esac
done
