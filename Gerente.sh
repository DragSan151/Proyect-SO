#!/bin/bash

opc=9
clear
while [ "opc" != "0" ]
do

echo "-------------------------------"
echo "Bienvendio al menu de Gerente"
echo "-------------------------------"

echo "1) Dar de alta a un Administrativo"
echo "2) Dar de baja a un Administrativo"
echo "3) Modificar datos de un Administrativo"
echo "4) listar Administrativo"
echo "5) Buscar Administrativos"
echo "6) listar Clientes"
echo "7) Buscar Cliente"
echo "0) Salir"


read opc
case $opc in

              1)echo "Dar alta a un Administrativo"
        read -p "Ingrese el nombre: " nombre
        read -p "Ingrese el password: " password
        read -p "Ingrese la cedula:  " cedula
        Adminis=$( grep "$nombre" Usuario.txt |  cut -f 3 -d":" )
	NombreIgual=$( grep "$nombre" Usuario.txt | cut -f 1 -d":"  )


	if [ "$NombreIgual" == "$nombre" ]
	then
	echo "Usuario ya existe .... "
	fecha=$( date +'%d/%m/%Y %H:%M' )
        echo "El Usuario ya existe $nombre $fecha" >> log.txt
	else
        echo $nombre:$password:Administrativo:$cedula >>Usuario.txt
        cat Usuario.txt
	fi

;;

              2)echo "Dar debaja a Administrativo"
        cat Usuario.txt
        read -p "Ingrese el Nombre " nombre
        Adminis=$( grep "$nombre" Usuario.txt | cut -f 3 -d":" )

         if [ "$Adminis" == "Adminsitrativo" ]
         then
          NombreIgual=$( grep "$nombre" Usuario.txt | cut -f 1 -d":"  )

	if [ "$NombreIgual" == "$nombre" ]
	then
        linea=$( grep "$nombre" Usuario.txt )
	echo "Administrativo Encontrado .... "
	echo "Administrativo dando de baja"
       	sed -i  "/$linea/d" Usuario.txt
	cat Usuario.txt

	else
        echo "Administrativo no encontrado "
        echo "Pudo aver ingresado incorrectamente el nombre porfavor vea los nombres a continuacion"
        cat Usuario.txt
	fecha=$( date +'%d/%m/%Y %H:%M' )
        echo "El Administrativo no se encontro $nombre $fecha" >> log.txt
        fi

         else
         echo "Error al ingresar el nombre del Administrativo"
         fecha=$( date +'%d/%m/%Y %H:%M' )
        echo "El Administrativo no se encontro $nombre $fecha" >> log.txt
         fi
;;

              3)opciones=6
	clear
	while [ "$opciones" != "0" ]

	do
    	echo   "Modificar datos"
     	 echo   "Que dato quieres modificar  "
     	 echo   "1)Contraseña"
     	 echo   "2)Cedula"
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
	Cedula=$( cut -f 3 -d":" Usuario.txt)
	fecha=$( cut -f 4 -d":" Usuario.txt)
	read -p "Ingrese la nueva contraseña " NewPass
	sed -i /$nombre/c\ $NameEq:$NewPass:$Cedula:$fecha Usuario.txt
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
	fecha=$( cut -f 4 -d":" Usuario.txt)
	read -p "Ingrese la nueva cedula " NewCedula
	sed -i /$nombre/c\ $NameEq:$password:$NewCedula:$fecha Usuario.txt
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
              
              4)echo "Listando Administrativos"
	cat Usuario.txt
              ;;
              5)if [ -f Usuario.txt ]
	then
		opcion=5

		while [ "$opcion" != "0"  ]

		do

       		echo "Buscar datos de usuario"
       		echo "1)Buscar por nombre"
       		 echo "2)Buscar por password"
       		 echo "3)Buscar por la cedula"
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
              6)echo "Listando Clientes"
	cat Clientes.txt
              ;;
              7)
              ;;
              0)exit
              ;;

esac
done
