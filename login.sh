#!/bin/bash
chmod u+x ./Administrador.sh
chmod u+x ./Administrativo.sh
chmod u+x ./Gerente.sh

echo "--------------"
echo "--Bienvendio--"
echo "--------------"

opc=20

while [ opc!=0 ]
do
if [ -f Usuario.txt ]
then
	sleep 0,5
else
    echo Admin:Admin:Administrativo:1 >> Usuario.txt
fi

read -p "Ingrese Su Nombre: " nombre

read -p "ingrese Su Contraseña: " contra

verNombre=$(grep "$nombre"  Usuario.txt | cut -f 1 -d: )

verContra=$(cut -f 2 -d: Usuario.txt | grep ^$contra$ )

verUser=$(grep "$nombre" Usuario.txt | cut -f 3 -d: )

if [ "$verNombre" = "$nombre" ] && [ "$verContra" = "$contra" ] 
then 
   if [ "$verUser" = "Administrador" ]
   then 
	./Administrador.sh
   fi

   if [ "$verUser" = "Administrativo" ] 
   then 
        ./Administrativo.sh
   fi
	
   if [ "$verUser" = "Gerente" ] 
   then 
        ./Gerente.sh
   fi
else
    echo "Usuario Incorrecto"
    echo $nombre:$contra >> Errores.txt
fi
done
