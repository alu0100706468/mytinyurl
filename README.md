Acortador de Urls
=========
Sistemas y Tecnologías web
---------------------------


Objetivo
-----

Crear una aplicación que permita acortar urls, donde el usuario podrá proporcionar un nombre personalizado para la url deseada.

También dispondrá de una parte de usuarios logeados, donde se podrá ver todas las urls acortadas con anterioridad.

Funcionamiento
-----

Hay dos formas posibles de ver el funcionamiento de la aplicación, una mediante la web, gracias a Heroku, y otra desde local.

1. Visualización en Heroku
    
    Para poder ver la aplicación en dicha plataforma, haz click [aquí].
    Una vez ahí acorta tu url, o si quieres guardarlas ¡registrate!, lo podrás hacer mediante Google, Github o Facebook.

2. Visualización en local

    Primero se ha de clonar el repositorio de github [mytinyurl], de la siguiente forma: 
    
    ```sh
    user@ubuntu-hp:~$ git clone git@github.com:alu0100706468/mytinyurl.git
    ```
    Una vez clonado el repositorio, y situado en el directorio, modifique el archivo config_filled.yml con sus claves(recomendado). Y a continuación ejecuta bundler:
    
    ```sh
    user@ubuntu-hp:~/mytinyur$ bundle install
    ```
    
    Una vez hecho todo lo anterior, procede a ejecutar *rake*, y por defecto se empezará a ejecutar.
    
    Una vez en ejecución, abre el navegador y escribe en la barra de direcciones *localhost:9292* y accederás a la web de la aplicación:
    
    ![ejemplo navegador](/img/ejemplo.png)
    
    Y ya, sólo has de dar autorizacion mediante google, y podrás ver el resultado.
    
    

[aquí]:http://my-tiny-url.herokuapp.com
[mytinyurl]:https://github.com/alu0100706468/mytinyurl.git
