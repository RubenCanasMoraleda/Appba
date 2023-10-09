<a name="br1"></a> 

2º CFGS

Desarrollo de Aplicaciones Multiplataforma

2022/2023

Rubén Canas Moraleda

Juan Manuel González Morcillo



<a name="br3"></a> 

**Definición del proyecto**

**Ámbito**

La Autoridad Portuaria necesita una solución efectiva para gestionar las

ausencias, presencia, documentación y notificaciones de sus empleados. Actualmente,

este proceso se realiza de forma web, mientras que con una aplicación móvil sería más

accesible y rápida a la hora de tramitar operaciones. La aplicación propuesta permitiría

una gestión más eficiente y automatizada de estos procesos, lo que ahorraría tiempo y

recursos valiosos para la organización. Sin la aplicación, la gestión de los procesos

relacionados con los empleados sería mucho más compleja y difícil de llevar a cabo de

manera efectiva, lo que podría generar problemas en la toma de decisiones y en la

gestión global de la organización. En resumen, la aplicación propuesta es

imprescindible para optimizar la gestión de los recursos humanos en la Autoridad

Portuaria y garantizar el buen funcionamiento de la organización en su conjunto.

**Alcance del proyecto**

Teniendo en cuenta la envergadura del proyecto y el plazo disponible, hemos

considerado que las funcionalidades base del proyecto sean de gestión de solicitud de

ausencia y gestión de presencia. Si disponemos del tiempo suficiente, nos

enfocaremos en la gestión de documentación. Por último, quedaría la gestión de

notificaciones que sería la última integración del proyecto si es posible en el plazo,

aunque prevemos que el plazo sea demasiado ajustado para llevar a cabo.

**Tecnología de la aplicación**

Para la parte del cliente vamos a usar el framework de flutter, diseñado para

aplicaciones Android, iOS y Web. Con respecto al Back End pretendemos usar

MariaDB para la gestión de la Base de Datos y Laravel para crear la API.




<a name="br8"></a> 

**Especificación funcional del sistema**


**Manual Técnico**

La instalación de la aplicación es tan sencilla como abrir el archivo apk de

instalación. En cuanto a la versión de MySQL, hemos usado la 8.0.21. Para realizar la

conexión entre la base de datos y la aplicación, nos hemos ayudado del framework

Laravel en su versión 9, que usa internamente PHP 8. Para el desarrollo de la propia

aplicación disponíamos del framework Flutter con versión 3.11 basado en dart 3.1. En

cuanto a la compatibilidad con dispositivos móviles, la aplicación está pensada para

ejecutarse en dispositivos con una versión mínima 19 para Android y 11 para iOS

**Licencia de uso y desarrollo**

Hemos optado por usar una licencia Creative Commons, en concreto la licencia

CC BY-NC-ND 4.0, que permite la compartir esta aplicación bajo las condiciones

siguientes:

Attribution — Debe reconocer adecuadamente la autoría, proporcionar un enlace

a la licencia e indicar si se han realizado cambios. Puede hacerlo de cualquier manera

razonable, pero no de una manera que sugiera que tiene el apoyo del licenciador o lo

recibe por el uso que hace.




<a name="br9"></a> 

NonCommercial — No puede utilizar el material para una finalidad comercial.

NoDerivatives — Si mezcla, transforma o crea a partir del material, no puede

difundir el material modificado.

No hay restricciones adicionales — No puede aplicar términos legales o

medidas tecnológicas que legalmente restrinjan realizar aquello que la licencia permite.

**Corolario**


**Análisis crítico para plantear posibles mejoras**

A pesar de intentar darle la funcionalidad más completa posible a nuestra

aplicación, debido a las limitaciones de tiempo presentes hemos tenido que excluir

ciertos componentes o funcionalidades. A continuación se plantea una lista con

posibles mejores a este proyecto:

● Arreglar el splash screen, cuya funcionalidad se encuentra implementada

pero con algún tipo de fallo.

● Agregar al calendario que se despliega en la pantalla de crear solicitud

las festividades locales y fines de semana.

● Comprobaciones de seguridad para las peticiones del backend.

● Permitir a los empleados de RRHH gestionar los parámetros por defecto

y de los empleados

● Aumentar el feedback de los estados de las peticiones vía Internet


**Viabilidad**

En cuanto a la prospección del proyecto en el mundo real, es una idea surgida

de una necesidad presente, por lo que con la conecta conexión con el sistema

portuario y unas ligeras adaptaciones para adecuar los modelos y asegurar la




<a name="br10"></a> 

compatibilidad entre la aplicación y los datos ya existentes de la autoridad portuaria

consideramos que el proyecto cuenta con una alta viabilidad.

**Bibliografía**

<https://creativecommons.org>

<https://zeroheight.com/5b2abf530/p/96bb35-apba-design-system>

<https://docs.flutter.dev/>

<https://pub.dev/packages/flutter_map>

<https://pub.dev/packages/geolocator>

<https://pub.dev/packages/file_picker>

<https://pub.dev/packages/dio>

<https://pub.dev/packages/google_fonts>

<https://pub.dev/packages/cupertino_icons>

<https://pub.dev/packages/shimmer>

<https://pub.dev/packages/font_awesome_flutter>

<https://pub.dev/packages/latlong2>

<https://pub.dev/packages/provider>

<https://pub.dev/packages/flutter_svg>

<https://pub.dev/packages/intl>

<https://pub.dev/packages/permission_handler>

<https://pub.dev/packages/flutter_native_splash>

<https://pub.dev/packages/shared_preferences>





