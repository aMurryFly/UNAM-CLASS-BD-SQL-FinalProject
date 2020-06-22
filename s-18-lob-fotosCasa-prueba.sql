--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Prueba de manejo de objetos LOB

Prompt MOSTRANDO INFORMACION BLOB
col nombre_archivo format a30

select imagen_id,nombre_archivo,dbms_lob.getlength(imagen) as longitud_imagen
from imagen;


prompt DONE S-018!
