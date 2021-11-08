#!/bin/bash

opc=12

while [ "$opc" != "0"  ]

do
echo "------------------------------"
echo "   Bienvenido Administrador   "
echo "------------------------------"

echo "1)Dar de alta a usuarios"
echo "2)Dar de baja a usuarios"
echo "3)Modificar datos de usuarios"
echo "4)Listar usuarios"
echo "5)Buscar datos de usuario"
echo "6)Ver registro de errores"
echo "7)Ver informaci�n del sistema"
echo "8)Respaldar datos"
echo "9)Regresar al login"
echo "0)Salir"

read opc

case $opc in

1)echo "Dar alta a un usuario"
        read -p "Ingrese el nombre: " nombre
        read -p "Ingrese el tipo de Usuario: " tipo
        read -p "Ingrese el password: " password
        read -p "Ingrese la cedula:  " cedula

	NombreIgual=$( grep "$nombre" Usuario.txt | cut -f 1 -d":"  )

	if [ "$NombreIgual" == "$nombre" ]
	then
	echo "Usuario ya existe .... "
	fecha=$( date +'%d/%m/%Y %H:%M' )
        echo "El Usuario ya existe $nombre $fecha" >> log.txt
	else
        echo $nombre:$password:$tipo:$cedula >>Usuario.txt
	fi
;;

2)
        echo "Dar debaja a un usuario"
        read -p "Ingrese el Nombre " nombre
        NombreIgual=$( grep "$nombre" Usuario.txt | cut -f 1 -d":"  )
        linea=$( grep "$nombre" Usuario.txt )

	if [ "$NombreIgual" == "$nombre" ]
	then
	echo "Usuario Encontrado .... "
	echo "Usuario dando de baja"
       	sed -i  "/$linea/d" Usuario.txt
	cat Usuario.txt

	else
        echo "Usuario no encontrado "
        echo "Pudo aver ingresado incorrectamente el nombre porfavor vea los nombres a continuacion"
        cat Usuario.txt
	fecha=$( date +'%d/%m/%Y %H:%M' )
        echo "El usuario no se encontro $nombre $fecha" >> log.txt

	fi
;;

3)
	opciones=6
	clear
	while [ "$opciones" != "0" ]

	do
    	echo   "Modificar datos"
     	 echo   "Que dato quieres modificar  "
     	 echo   "1)Contraseña"
     	 echo   "2)tipo de Usuario"
     	 echo   "3)Cedula"
     	 echo   "0)Salir"
     	 echo   "Ingrese la opcion "

	read opciones
	case $opciones in
	1)

	cat Usuario.txt
	read -p "Ingrese el nombre del usuario a modificar " nombre
	NameEq=$( grep "$nombre" Usuario.txt | cut -f 1 -d ":" )

	if [ $nombre == $NameEq ]
	then
	TipoU=$( cut -f 3 -d":" Usuario.txt)
	Cedula=$( cut -f 4 -d":" Usuario.txt)
	read -p "Ingrese la nueva contraseña " NewPass
	sed -i /$nombre/c\ $NameEq:$NewPass:$TipoU:$Cedula Usuario.txt
	else
	echo "Error"
	fi
	;;

	2)
	cat Usuario.txt


	read -p "Ingrese el nombre del usuario a modificar " nombre
	NameEq=$( grep "$nombre" Usuario.txt | cut -f 1 -d ":" )

	if [ $nombre == $NameEq ]
	then
	Pass=$( cut -f 2 -d":" Usuario.txt)
	Cedula=$( cut -f 4 -d":" Usuario.txt)
	read -p "Ingrese el nuevo tipo de usuario " NewUser
	sed -i /$nombre/c\ $NameEq:$Pass:$NewUser:$Cedula Usuario.txt
	else
	echo "Error"
	fi
	;;

	3)
	cat Usuario.txt
	read -p "Ingrese el nombre del usuario a modificar " nombre
	NameEq=$( grep "$nombre" Usuario.txt | cut -f 1 -d ":" )

	if [ $nombre == $NameEq ]
	then
	Pass=$( cut -f 2 -d":" Usuario.txt)
	User=$( cut -f 3 -d":" Usuario.txt)
	read -p "Ingrese la nueva cedula  del usuario " NewCedula
	sed -i /$nombre/c\ $NameEq:$Pass:$User:$NewCedula Usuario.txt
	else
	echo "Error"
	fi

	;;
	0)exit
	;;
	*)
	echo "Error en el ingreso"
	;;
	esac
	done
	;;
;;
4)
	echo "Listando Usuario"
	cat Usuario.txt
;;
5)
	if [ -f Usuario.txt ]
	then
		opcion=5

		while [ "$opcion" != "0"  ]

		do

       		echo "Buscar datos de usuario"
       		echo "1)Buscar por nombre"
       		 echo "2)Buscar por apellido"
       		 echo "3)Buscar por tipo de usuario"
      	  	echo "4)Buscar por contraseña"
       		 echo "0)Volver al menu"
		read opcion
		case $opcion in
        	1) 
		cut -f 1 -d : Usuario.txt
       		 ;;
       		 2) cut -f 2 -d : Usuario.txt
       		 ;;
       		 3) cut -f 3 -d : Usuario.txt
       		 ;;
       		 4) cut -f 4 -d : Usuario.txt
       		 ;;
       		 0)
		echo "Salio"
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
;;

6)  
	echo "Registro de errores "
	cat Errores.log
;;

7)
	echo "Mostrando el sistema "
	wc -l Usuario.txt
        wc -l Clientes.txt
        wc -l Errores.log
;;

8)
	echo "Respaldando los datos ....."
	read -p "Ingrese La carpeta en la que quiere respaldar" carpeta
	if [ -f $carpeta ]
	then
		cp Usuario.txt $carpeta
		cp Clientes.txt $carpeta
		cp log.txt $carpeta
	else
		echo "Ubicacion no valida"
	fi
;;
9)
	./login.sh
;;

0)
	exit
;;

esac

done
