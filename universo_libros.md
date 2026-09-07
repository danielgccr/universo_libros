---
title: Un universo libre de libros y de iniciativas complicadas
subtitle: Propuesta técnica, pedagógica y económica para la soberanía del material docente en centros públicos
author: Daniel García
lang: es
papersize: a4
margin: 
 x: 2.5cm 
 y: 2.5cm 
fontsize: 12pt 
font: "Linux Libertine"
toc: true
toc-title: "Índice"
---
# Prefacio

En España el conocimiento rara vez ha sido un bien comunal: ha funcionado como custodio y patrimonio de burócratas, gremios y despachos, véase el sangrante ejemplo de los temarios de oposiciones custodiados por academias. La tradición de conocimiento libre, que implica también debate y rendición de cuentas, no ha sido comprendida (ni querida) por parte de no pocos estamentos de la vida pública.

Incluso las nociones de lo público están viciadas: libros de texto subvencionados, pero no libres. Y se financia a empresas privadas, como el grupo Santillana, sin que repercuta en el público. Nuestro dinero engorda sus cuentas, y a cambio la información no es libre, cuando desea serlo.

Frente a dichas inercias, aquí os mostraremos instrucciones realistas, sin tener que recurrir a millonadas, de cómo ser libres en base a dos pilares tecnológicos que existen desde hace décadas y que sostienen gran parte de la infraestructura crítica del mundo moderno: el **texto plano** y el **control de versiones**.

El **texto plano** rescata la palabra escrita del secuestro de los formatos propietarios; el **control de versiones** convierte la labor solitaria del docente en una construcción colectiva, acumulativa, transparente y libre de peajes.

La información (y el conocimiento) desean ser libres, y las siguientes páginas honrarán ese principio.
# Presentación

Hablan de [bancos de préstamo de libros](https://www.comunidad.madrid/educacion/programa-accede). Hablan de libros de texto anuales que se quedan obsoletos con cambios en las leyes educativas. La letanía de muchos padres, lesiva en tiempo, colas, burocracia, libros que no se pueden subrayar o en dinero.

Así es el universo de los libros de texto en Secundaria, ¿pero y si hubiese otra forma? 

La primera pieza aquí a descubrir es el **texto plano**. Escribir no debería ser pelear contra márgenes que se descuadran, menús interminables o formatos cerrados que exigen pagar licencias anuales sólo para abrir un documento en condiciones. El texto plano es la esencia misma de la escritura digital: caracteres puros, sin trampa ni cartón, legibles por cualquier ordenador del planeta, hoy o dentro de cincuenta años.

![[Pasted image 20260906213536.png]]

Adoptar este enfoque supone una liberación cognitiva para el docente. Al escribir en texto plano (usando convenciones directas como **Markdown**) se separan dos tareas que nunca debieron mezclarse: el **fondo** y la **forma**. El profesor se centra en estructurar las ideas, en argumentar y en enseñar; de la estética, la tipografía y el diseño final ya se encargarán las herramientas automáticas más adelante. Además, el texto plano pesa kilobytes, es mucho más resistente a la corrupción que formatos como Word (donde un fallo menor puede inutilizar el documento al completo), no oculta código basura y rescata al centro educativo de la dependencia de cualquier monopolio de software.

La segunda es el **control de versiones**, estándar en el desarrollo de software, ya que permite trazar cambios y tener un historial de un determinado proyecto. Para los docentes, tiene aplicaciones prácticas que, para empezar, evitan engrudos del estilo `Tema4_v2_DEFINITIVO_corregido.docx` y permiten registrar la evolución de los apuntes, más si en cada _commit_ se usan descripciones claras, como «Añadido el tema 4 a las notas de Lengua en 4º de la ESO: análisis sintáctico».

![Ejemplo de control de versiones](https://upload.wikimedia.org/wikipedia/commons/9/91/Forgejo_screenshot_dark_mode.png)

Y nos extenderemos en ambos conceptos en los siguientes apartados. El objetivo de esta lectura es no asimilar de golpe todo lo que se muestre aquí, eso sería inviable, sino tres: **mostrar una alternativa viable**, **servir de referencia** y **sembrar la curiosidad modular**.

Quien lo lea con calma no necesita adoptar el paquete completo; puede empezar probando **Zotero** para ordenar sus fuentes en el navegador, animarse a redactar un tema suelto en **Markdown** para no pelear con Word, o descubrir que con **Pandoc** un texto plano se convierte en cuadernillo en tres segundos.
# La soberanía del texto plano

El primer cambio de paradigma consiste en despojarse del engrudo visual y de suites ofimáticas cerradas como Microsoft Office, pasando al **texto plano**. Escribir no es maquetar. Cuando los profesores adoptan el texto plano, e.g., a través de **Markdown**, la atención está en el contenido.

* En el día a día, la opción más sencilla e intuitiva es **Markdown**, viable en cualquier ordenador e incluso móviles, con numerosos editores como Obsidian, MarkText o Notion. La ventaja es que Markdown puede trasladarse a numerosos formatos como HTML o PDF.
*  **Hablemos de rigor científico y tipográfico**: cuando necesitamos gráficas, fórmulas matemáticas o control milimétrico, el texto plano escala naturalmente a LaTeX o Typst. También el colegio puede crear sus propios temas para una coherencia visual.
* Por último, el **rigor bibliográfico** se completa diciéndole adiós a los enlaces rotos pegados a mano a pie de página. Mediante herramientas estándar y abiertas como **Zotero** (con su conector para el navegador web, [Zotero Connector](https://www.zotero.org/download/)) o **JabRef**, capturar una fuente de internet, un artículo o una ley en el BOE cuesta un solo clic. La extensión _Better BibTeX_ mantiene sincronizado automáticamente un archivo `referencias.bib` en segundo plano. Los docentes solo tienen que invocar la cita en su texto plano con una clave sencilla como `[@garcia2024]` y el sistema maquetará la bibliografía con precisión académica al compilar.

![Un editor en Markdown](https://itsfoss.com/content/images/wordpress/2022/08/sidebar-view-marktext.png)

Y podemos dar razones para usar Markdown como el formato por defecto.

- Fácilmente portable a cualquier lado. Bajo riesgo de corrupción de datos.
- Perdurará años, incluso generaciones.
- Puede ser transformado a numerosos formatos con unos pocos comandos, ahorrando tiempo a la larga.
- Puede combinarse con un sistema de control de versiones y trazar rápidamente cualquier cambio.
- Puede ser el sustento de vuestras páginas web.
- ¡No te saldrás del teclado escribiendo, deja que fluyas!
- No dependerás de programas especiales.
- Legible de primeras en cualquier editor de texto.

# Control de versiones en las aulas

Si el material escolar es en texto plano, el colegio no necesita atarse a licencias privativas (sean suites ofimáticas o sistemas operativos) que secuestran los datos de los alumnos, así como pagar peajes recurrentes. El colegio instala su propia instancia de **Gitea** (o Forgejo), un entorno ético, ligero y soberano.

En este nuevo modelo:

1. **Los apuntes son de código abierto:** Los departamentos mantienen repositorios dinámicos. Un profesor puede corregir una errata y todos los estudiantes tienen la actualización al instante. El conocimiento se hereda curso a curso y se perfecciona.
2. **Trabajo editorial en equipo**. Las revisiones o ampliaciones de un tema se proponen mediante ramas y revisiones (_Pull Requests_), permitiendo que el departamento debata, revise y apruebe las mejoras del temario antes de consolidarlas. También los alumnos pueden comentar.
3. **Cambio de paradigma:** Sin artificios, los profesores manejan conceptos como ramas, versiones, colaboración asíncrona y estructuración de datos, habilidades que forman la columna vertebral del mundo digital contemporáneo.

Este modelo también implica cambios en el paradigma. Un **repositorio** es la «carpeta compartida del departamento», pero sin riesgo de que alguien borre por error el trabajo de otro.
## Coordinación y el fin de la ambigüedad: el valor del _commit_

Adoptar este flujo exige romper con la vaguedad. El control de versiones no funciona por inercia técnica; funciona por disciplina comunicativa. En este entorno no hay sitio para guardar sin más. Cada actualización de los apuntes exige un mensaje de confirmación (_commit_) que explique con precisión **qué se ha hecho y por qué**:

- **Inaceptable por inútil:** `cambios`, `corregido`, `archivo nuevo`, `subiendo tarea`.
- **Informativo y pedagógico:** «Añadido el tema 4 a las notas de Lengua de 4º de ESO: análisis de oraciones subordinadas sustantivas» o «Corregidas las erratas del ejercicio 3 de Cinemática en el tema 2».

Este hábito sintetiza el trabajo docente, hace vox pópuli las revisiones entre compañeros de departamento y convierte el historial del repositorio en una crónica pedagógica viva, estructurada y legible.
## Domesticar la fricción: cero terminales para el día a día

Cualquier propuesta que ignore la comodidad humana está condenada al fracaso. Si para participar los docentes tuvieran que generar pares de claves SSH, configurar túneles o memorizar comandos en consolas de texto, el proyecto moriría la primera semana. La experiencia de redacción y publicación debe ser accesible e intuitiva:

- **Conexión transparente sin SSH:** La sincronización con Gitea o Forgejo se realiza mediante **HTTPS**. El sistema operativo almacena las credenciales educativas de forma segura la primera vez; a partir de ahí, el intercambio de datos es automático e invisible para el usuario.
- **Organización clara por carpetas:** Cada departamento dispone de su estructura en disco local (por ejemplo: `Material_Docente/Lengua_4ESO/`). Se redacta en el editor habitual y las herramientas visuales detectan los archivos modificados.
- **Conversión sin complicaciones técnicas:** A la hora de compilar documentos, **Pandoc** actúa en segundo plano. Iniciativas como [`pandoc-gui`](https://github.com/Ombrelin/pandoc-gui) eliminan cualquier necesidad de usar comandos: basta con arrastrar el archivo Markdown a una pequeña ventana, elegir el formato deseado (PDF, DOCX o EPUB) y pulsar un botón. Y guardar los cambios en tu sistema de control de versiones.
# Reutilizar lo que ya existe: la infraestructura pública olvidada

No hace falta reinventar la rueda ni solicitar partidas presupuestarias extraordinarias. En prácticamente todas las comunidades autónomas, las consejerías de educación ya proporcionan a cada centro un **servidor web institucional, espacio de almacenamiento, dominios oficiales y cuentas corporativas** para docentes y alumnos.

El texto plano y los sitios estáticos son la vía más eficiente para aprovechar estos recursos:

- **Cero sobrecarga técnica:** Una web generada a partir de Markdown no depende de pesadas bases de datos que colapsan ante el tráfico simultáneo de cientos de familias. Es HTML puro: vuela, consume una fracción ínfima de ancho de banda y carga de forma instantánea incluso con conexiones móviles modestas.
- **Integración inmediata:** No se reemplaza la web institucional; simplemente se añade una subsección (`/apuntes`) donde se despliegan automáticamente los temarios actualizados tras cada revisión del departamento.
- **Identidad unificada:** Los directorios institucionales ya existentes (LDAP corporativo) se enlazan de forma directa con Gitea o Forgejo para evitar duplicar credenciales.
# La trampa de la escasez: del cupo físico a la abundancia digital

Los sistemas de préstamo de libros sufren una tara de diseño insalvable: gestionan un objeto físico limitado. Esto genera dinámicas perversas que cualquier equipo directivo y familia conoce bien:

- **Listas de espera y discriminación por cupo:** El presupuesto público rara vez cubre el ciento por ciento de las reposiciones de libros extraviados o deteriorados. Cada septiembre surgen los problemas: lotes incompletos, baremos socioeconómicos excluyentes o familias en lista de espera que acaban comprando a cuarenta euros el manual que faltó en el reparto.
- **Obsolescencia forzada por cambio editorial:** Cuando un departamento decide cambiar de editorial o se renueva el currículo legal, cientos de libros en perfecto estado físico van directamente a la basura porque no coinciden con la nueva edición comercial.
- **El libro intocable:** El alumno no puede subrayar, resolver actividades en los márgenes ni apropiarse del material porque la penalización por deterioro le excluye del banco de libros del curso siguiente.

El modelo de **texto plano e impresión a demanda dinamita la escasez por completo**:

- **Nulo coste marginal:** Un archivo Markdown no se desgasta, no ocupa espacio en un almacén y copiarlo para cien o mil estudiantes apenas cuesta.
- **Abundancia inmediata:** No existe el concepto de «quedarse sin libro». Si a mitad de curso llega un alumno, su temario está disponible en la web del centro desde el primer instante y su cuadernillo sale de la reprografía en tres minutos.
- **Fin de la fiscalización del desgaste:** Las familias y los docentes se liberan del tiempo invertido en revisar páginas selladas, borrar anotaciones a lápiz o tramitar expedientes de fianza en secretaría. El material en papel deja de ser un activo patrimonial que vigilar y vuelve a ser lo que siempre debió ser: una herramienta de estudio viva, económica y libre para anotar.

## Un solo origen: web ligera y papel a demanda

Rechazar el modelo editorial tradicional no implica rendirse a la tiranía de la pantalla permanente. El papel sigue y seguirá siendo un soporte insustituible para la concentración, la lectura profunda y el estudio libre de distracciones.

La ventaja del texto plano es que actúa como una **fuente única de la verdad**. A partir de los mismos archivos en el repositorio, la automatización genera dos salidas inmediatas:

1. **Una web sencilla y ligera:** Alojada en la propia infraestructura del centro, accesible desde cualquier navegador, rápida y libre de rastreadores.
2. **Documentos PDF listos para imprimir a demanda:** Cuadernillos maquetados con elegancia tipográfica que los alumnos o el centro pueden imprimir por temas según se vayan impartiendo.

La diferencia frente al manual de 300 páginas del banco de libros es sustancial: el cuadernillo impreso a demanda es un material vivo y fungible. El alumno lo puede subrayar, anotar en los márgenes, completar sus ejercicios y conservarlo como su propio cuaderno de aprendizaje.

## El bolsillo de las familias: números claros frente al sablazo de septiembre

El modelo tradicional es costoso para las familias: un lote escolar estándar en Secundaria (ocho o nueve asignaturas a una media de cuarenta euros por ejemplar) supone **entre 320 € y 360 € por hijo** [@anele_informe_2023; @ocu_vuelta_cole_2024; @bocm_precios_accede_2024], abonados en un único pago en la primera quincena de septiembre.

¿Qué ocurre si trasladamos este volumen a impresión a demanda? Estimando un curso completo con **ocho asignaturas**, unos **diez temas por asignatura** al año (ochenta temas en total) y un promedio de **veinte páginas por tema** (diez hojas a doble cara) [@contratacion_reprografia_publica; @tarifas_reprografia_academica]:

| Modelo de estudio                                    | Coste por tema | Gasto mensual (9 meses)  | **Coste total del curso / alumno** | Ahorro frente al libro tradicional |
| ---------------------------------------------------- | -------------- | ------------------------ | ---------------------------------- | ---------------------------------- |
| **Libro de texto tradicional**                       | —              | Pago único en septiembre | **~340 €**                         | 0 %                                |
| **Impresión a demanda (B/N integral)**               | ~0,50 €        | ~4,40 € / mes            | **~40 €**                          | **-88 %**                          |
| **Impresión a demanda (Mixto: B/N + láminas color)** | ~0,90 €        | ~8,00 € / mes            | **~72 €**                          | **-78 %**                          |
| **Impresión a demanda (Color integral)**             | ~1,40 €        | ~12,40 € / mes           | **~112 €**                         | **-67 %**                          |
Las ventajas presupuestarias van más allá del ahorro porcentual:

- **Financiación natural sin intereses:** El gasto no asfixia en la cuesta de septiembre. Se abonan entre **5 € y 12 € al mes** en reprografía según el ritmo real de avance de las clases.
- **Pago solo por lo impartido:** En los libros tradicionales se paga por 300 páginas aunque el profesor solo use 180. Con la impresión tema a tema, si por calendario o adaptación curricular se imparten 8 temas en lugar de 10, no se paga ni un céntimo de papel sobrante.
- **Flexibilidad absoluta de formatos:** Quien prefiera estudiar en pantalla no gasta nada en papel; quien prefiera solo imprimir resúmenes gasta la mitad; quien necesite subrayar a rotulador y escribir a mano invierte apenas unos céntimos por lección sin miedo a estropear un libro prestado.

# De la escuela al sistema

Si este modelo es viable dentro de un instituto, a escala autonómica representa una **revolución estructural del gasto público y la soberanía pedagógica**. Administraciones como la Comunidad de Madrid destinan anualmente decenas de millones de euros de dinero público al programa Accede [@acuerdo_gobierno_accede]; un caudal continuo de transferencias que termina en las cuentas de corporaciones editoriales privadas a cambio de licencias temporales o manuales cerrados.

¿Qué sucedería si la administración autonómica asumiera la titularidad del código fuente de sus propios materiales educativos?

## El modelo de las universidades punteras: el estándar abierto

En la educación superior internacional más exigente, el manual comercial tradicional es un anacronismo. Cursos de referencia global como el [**CS224N de la Universidad de Stanford**](https://web.stanford.edu/class/cs224n/) (o la red de cursos abiertos del MIT OpenCourseWare) demuestran cómo la docencia puntera se estructura en torno a la apertura técnica:

- Webs estáticas ultra-ligeras alojadas en servidores propios institucionales.
- Apuntes (_lecture notes_) redactados directamente por el profesorado en texto plano (LaTeX/Markdown) y compilados a PDF impecables.
- Dinamismo pedagógico: si un concepto evoluciona o un ejercicio genera dudas recurrentes, el cambio se incorpora esa misma tarde en el repositorio del curso.

Resulta contradictorio que, mientras la vanguardia académica internacional enseña mediante recursos abiertos, trazables y dinámicos, la Educación Secundaria española permanezca atada a los ciclos comerciales de reedición de editoriales privadas.

## El repositorio central y la autonomía de centro (El _fork_ docente)

A nivel autonómico, el objetivo no es imponer un manual único y doctrinario desde un despacho central, sino articular **un punto de partida público, modular y vivo**:

1. **La base institucional:** La Consejería de Educación mantiene el repositorio oficial de cada materia y nivel (por ejemplo, `madrid/lengua-4eso`), redactado y revisado por comisiones docentes con estricto apego al currículo.
2. **Autonomía y libertad de cátedra:** Ningún instituto está forzado a consumir el bloque cerrado. Cada departamento puede realizar una derivación (_fork_) del repositorio oficial hacia su propia instancia escolar y adaptarlo a su contexto: alterar el orden temático, profundizar en autores locales o añadir ejercicios de refuerzo.
3. **El aula que nutre al sistema:** La colaboración fluye en ambos sentidos. Si un profesor de un centro periférico diseña una explicación sobresaliente o detecta una errata en el temario general, puede proponer una aportación (_Pull Request_) al repositorio oficial de la Comunidad. Por primera vez, el talento de un docente particular revierte de forma directa en toda la red educativa regional.

Reorientar las partidas millonarias del modelo editorial hacia la infraestructura abierta no solo alivia el bolsillo de las familias; capitaliza las inversiones ya realizadas por la administración y devuelve el control pedagógico a los claustros.

# Un caso real: MC Libre

Lejos de ser una hipótesis teórica, este enfoque cuenta con precedentes de enorme éxito y longevidad en el sistema educativo español. Un ejemplo paradigmático es el portal pedagógico **mclibre.org**, desarrollado por el profesor Bartolomé Sintes Marco.

![[Pasted image 20260906214415.png]]

Durante más de veinte años, miles de alumnos y docentes de Secundaria, Bachillerato y Formación Profesional han utilizado sus materiales didácticos, los cuales comparten los mismos pilares de esta propuesta:

- **Formatos abiertos e interoperables:** Materiales construidos en estándares web abiertos, ligeros y descargables íntegramente para funcionar sin conexión si el aula de informática se queda sin red.
- **Independencia absoluta de proveedores:** Ninguna empresa editorial ni multinacional tecnológica intermedia entre el docente y el contenido. El conocimiento se actualiza curso a curso a demanda de las necesidades pedagógicas reales, no de calendarios comerciales de reedición.
- **Filosofía colaborativa:** El material se publica bajo licencias libres (Creative Commons), invitando a la reutilización y mejora continua por parte de otros docentes.

Plataformas como mclibre.org demuestran que cuando un centro basa sus contenidos en formatos universales y libres los materiales no caducan. El gasto para las familias se minimiza y el profesorado recupera el control pedagógico real de su labor. La incorporación de Gitea y Pandoc es el siguiente paso lógico: dotar a esa misma filosofía de una infraestructura moderna para colaborar en equipo y generar cuadernillos de papel al instante.

# Preguntas frecuentes para claustros y equipos directivos

**¿Qué personal técnico y organizativo se necesita para poner en marcha y mantener este sistema?**

Una de las grandes fortalezas del texto plano y de herramientas como Gitea es que **no requieren un departamento informático dedicado ni contrataciones externas multimillonarias**. La carga de trabajo se distribuye entre perfiles que los centros de Secundaria ya tienen regulados en plantilla:

- **Coordinador TIC / Responsable de Medios Informáticos (figura docente ya existente):**
    
    - **Rol en el despliegue:** Dedicar unas pocas horas iniciales a instalar la instancia de Gitea (mediante un contenedor Docker ligero o paquete del sistema) en el servidor escolar que la consejería ya provee, y vincularlo al directorio de usuarios existente (LDAP institucional).
    - **Mantenimiento habitual:** Supervisar las copias de seguridad periódicas (que al ser texto plano pesan apenas unos pocos megabytes) y aplicar actualizaciones de seguridad esporádicas. El consumo de CPU y memoria es tan bajo que la máquina no requiere intervenciones constantes.
        
- **Profesorado dinamizador o «pionero» (1 o 2 docentes por departamento):**
    
    - **Rol:** No programan; actúan como referentes de materia. Crean las plantillas básicas del departamento (el archivo `.bib` base para referencias y la estructura de carpetas por temas) y resuelven dudas cotidianas a sus compañeros de claustro durante las reuniones de departamento.
        
- **Personal de reprografía / Conserjería del centro:**
    
    - **Rol:** Idéntico al que ya realizan a diario. Su única tarea es recibir los PDF generados de forma automática e imprimirlos según las solicitudes de cuadernillos que hagan las familias o los departamentos al arrancar cada unidad didáctica.

Al prescindir de arquitecturas complejas de bases de datos pesadas, servidores dedicados o licencias que caducan, la administración del sistema se reduce a una tarea de bajo impacto que cabe perfectamente en las horas lectivas de reducción asignadas a la coordinación tecnológica del instituto.

**¿Cómo es el día a día del docente redactando apuntes y cómo le afecta este cambio de paradigma frente al libro comercial?**

El libro tradicional actúa muchas veces como un salvavidas frente a la sobrecarga horaria y burocrática, pero en la práctica acaba siendo un corsé: se omiten temas enteros, se complementa con fotocopias sueltas y se supedita el ritmo del aula al índice de una editorial comercial. El paso al texto plano transforma la preparación de clases en una labor acumulativa y colaborativa:

- **El mito del «lienzo en blanco»:** Nadie empieza desde cero en septiembre. Se parte de materiales propios ya existentes en Word (convertibles a Markdown en segundos con Pandoc), de apuntes heredados del departamento o de Recursos Educativos Abiertos (REA) de la comunidad docente.
- **Trabajo en equipo real dentro del departamento:** En el modelo editorial, cada profesor suele estar aislado en su aula con su manual. Con el control de versiones, el departamento reparte esfuerzos: un docente prepara la unidad de Termodinámica, otro actualiza los ejercicios de Cinemática y un tercero pule las lecturas complementarias. Las mejoras de uno benefician al instante a los demás.
- **El fin del material efímero y disperso:** Actualmente, los añadidos del profesor acaban en fotocopias sueltas que los alumnos pierden o en carpetas olvidadas del ordenador de casa. Con este flujo, cualquier retoque que se haga tras una clase («este ejercicio ha resultado confuso, añado una aclaración») queda registrado en el repositorio y se hereda de forma natural al curso siguiente. El patrimonio didáctico del profesor no se reinicia cada septiembre; crece año a año.
- **Autonomía pedagógica total:** El temario se ajusta a la realidad del grupo. Si el curso avanza más lento, no hay que justificar ante las familias por qué se quedó medio libro sin abrir; si hay un acontecimiento histórico o científico de actualidad, se redacta una ficha de dos párrafos en Markdown, se compila y esa misma tarde está disponible en la web y lista para reprografía.

**¿Qué programas concretos pueden instalar los profesores en sus ordenadores Windows para trabajar día a día?**

No hace falta abandonar el entorno habitual de ventanas ni aprender programas oscuros. Para Windows existen herramientas gratuitas, portátiles y visualmente transparentes tanto para escribir como para controlar las versiones de los documentos:

- **Para redactar (editores visuales sin fricción):**
    
    - **MarkText:** Gratuito y de código abierto. Funciona en modo _WYSIWYG_ (lo que ves es lo que obtienes): al escribir `# Título`, el texto se transforma al instante en un encabezado maquetado sin dejar los símbolos a la vista. La sensación es idéntica a escribir en un procesador tradicional limpio y sin distracciones.
    - **[Obsidian](https://obsidian.md):** Gratuito para uso educativo. Ideal para estructurar cursos enteros como carpetas en Windows. Incluye árbol de archivos lateral, enlaces entre temas, corrector ortográfico en español y previsualización en vivo.
    - **VSCodium/VS Code:** Para departamentos de Ciencias (Matemáticas, Física y Química, Tecnología), ofrece entorno avanzado con previsualización simultánea de fórmulas complejas en **Typst** o **LaTeX**. También incorpora control de versiones.
        
- **Para controlar versiones de forma visual (fuera de VS Code):**
    
    Para ver qué se ha modificado sin abrir terminales ni editores técnicos, existen dos soluciones de escritorio idóneas:
    
    - **GitHub Desktop (o GitKraken):** Compatible con servidores Gitea vía HTTPS. Al abrirlo, muestra una lista con los archivos modificados. Al pinchar en un tema, la pantalla se divide en dos: resalta en **rojo** las frases que se han borrado y en **verde** los párrafos que se han añadido. En la esquina inferior izquierda solo hay que rellenar el recuadro «¿Qué has cambiado?» y pulsar el botón azul _Confirmar y sincronizar_.
    - **[TortoiseGit](https://tortoisegit.org):** Se integra directamente en el Explorador de Archivos de Windows. Las carpetas de las asignaturas muestran iconos sobre el icono del archivo: un tic verde si el tema está al día y un círculo rojo si se ha modificado. Basta con hacer clic derecho sobre la carpeta, pulsar _Comparar cambios_ para revisar las diferencias línea a línea, redactar el mensaje de confirmación y enviar.
        
- **Para la gestión bibliográfica y exportación:**
    * **Zotero + Zotero Connector:** Gratuito, de código abierto y disponible en Windows. Se integra en el navegador web habitual (Chrome, Firefox, Edge). Cuando el profesor consulta un artículo, una página de divulgación o una ley, pulsa el botón del conector y Zotero extrae título, autores, fecha y enlace al instante. Con el complemento gratuito _Better BibTeX_, Zotero exporta y actualiza de forma transparente el archivo `referencias.bib` de la asignatura cada vez que se añade una fuente.
    - **[JabRef](https://www.jabref.org):** Software con instalador nativo para Windows. Permite introducir el ISBN de un libro para rellenar automáticamente todos sus datos y mantener el archivo `referencias.bib` al día sin editar código bibliográfico a mano.
      ![[Pasted image 20260906214906.png]]
    - **[pandoc-gui](https://github.com/Ombrelin/pandoc-gui):** Aplicación de ventana flotante para Windows en la que se arrastra el archivo `.md`, se selecciona en un desplegable el formato deseado (PDF maquetado o Word `.docx` para trámites administrativos) y se pulsa un botón para obtener el documento final listo para reprografía.

**¿Cuánto tiempo de adaptación requiere para el profesorado no técnico?**

El aprendizaje se divide en dos fases muy breves:

- **Escribir en Markdown:** Se asimila en menos de 20 minutos. Consiste en aprender cuatro convenciones básicas para estructurar el contenido (una almohadilla `#` para títulos, asteriscos `**` para negritas o guiones, `-`,  para listas). Un recurso al respecto es [Markdown Tutorial](https://www.markdowntutorial.com/) y hay páginas web para practicar libremente como [StackEdit](https://stackedit.io)
- **Entregar o sincronizar:** Gracias a interfaces visuales y botones integrados en el editor o en el explorador de Windows, el docente solo debe aprender a pulsar un botón de «guardar cambios» y escribir una frase descriptiva. No requiere aprender informática ni comandos abstractos. El foco sigue estando íntegramente en la redacción de la materia.

**¿Qué ocurre si el centro o el hogar se queda sin conexión a internet?**

El sistema sigue funcionando con total normalidad. A diferencia de suites ofimáticas en la nube (Google Docs, Microsoft 365) que se bloquean o impiden el acceso sin conexión, el texto plano reside de forma nativa en el disco duro del ordenador. Profesores y alumnos pueden:

- Seguir leyendo, redactando y editando sus apuntes sin cobertura.
- Guardar el trabajo localmente.
- Sincronizar los cambios con la plataforma del centro en el momento en que vuelva la red, sin perder una sola línea de texto ni depender de un servidor externo activo.

**¿Cómo gestiona este modelo la brecha digital y la falta de dispositivos en casa?**

El modelo reduce la brecha económica y técnica en lugar de ensancharla:

- **Independencia del hardware:** Los archivos de texto plano pesan kilobytes y no exigen ordenadores potentes ni tabletas modernas. Funcionan en equipos antiguos o reacondicionados que las plataformas comerciales dejan obsoletos.
- **El papel como red de seguridad:** Quien no disponga de ordenador en casa no queda excluido del aprendizaje. El alumno recibe el cuadernillo en papel impreso por la reprografía del colegio a bajo coste, disponiendo exactamente del mismo contenido que sus compañeros sin depender de pantallas obligatorias para estudiar.

# Glosario

- **BibTeX y JabRef:** Sistemas estandarizados para ordenar fuentes bibliográficas. En lugar de copiar y pegar enlaces largos a mano, permiten organizar libros y artículos en una ficha ordenada y citarlos de forma académica uniforme.
- **Bifurcación (_Fork_):** Copia personalizada y vinculada de un repositorio central que permite a un centro adaptar los materiales autonómicos a su propio ritmo sin perder las actualizaciones del temario original.
- **Confirmación (_Commit_):** Es el acto de consolidar un avance. Equivale a hacer un «guardado oficial» acompañado de una breve nota explicativa (_«Añadido el tema 4»_ o _«Corregidas las erratas del examen»_). Evita tener decenas de archivos con nombres como `Tema1_final_v2_este_sí.docx`.
- **Control de versiones (Git):** Un sistema que funciona como una «cámara de fotos temporal» para los documentos. Cada vez que alguien decide registrar un avance, el sistema guarda una copia exacta con una breve explicación. Permite revisar qué cambió, cuándo y volver atrás si hubo una equivocación.
- **Gitea/Forgejo:** Una plataforma web privada (similar a una nube escolar) donde se guardan esos historiales de documentos. Permite trabajar en equipo, revisar entregas y leer los materiales desde el navegador.
- **LaTeX:** Estándar clásico de edición y maquetación utilizado en la universidad y en publicaciones científicas internacionales. Está especializado en componer fórmulas matemáticas, ecuaciones químicas y documentos técnicos complejos con precisión milimétrica, evitando que los símbolos se descoloquen o pierdan nitidez al imprimirse. En este modelo, herramientas modernas como Typst recogen su testigo con una sintaxis más rápida y sencilla, pero conservando su misma exactitud gráfica.
- **Markdown:** Un método intuitivo de dar estructura al texto mientras se escribe. En lugar de buscar botones en barras de herramientas para poner negritas o títulos, se usan signos directos sobre el teclado (como `#` para un encabezado o `*` para una lista). Cualquier editor lo interpreta y lo muestra formateado de inmediato.
- **Pandoc:** Una herramienta conversora que actúa como un «traductor universal». Toma el texto plano redactado por el profesor y lo transforma, en cuestión de segundos, en un documento PDF listo para reprografía o en una página web.
- **Propuesta de cambio (_Pull Request_ o _Merge Request_):** La vía para colaborar sin pisarse el trabajo. Si un profesor mejora una unidad didáctica o detecta un fallo en los apuntes de otro compañero, no sobreescribe el texto directamente: le envía una sugerencia formal de cambios. El autor o el jefe de departamento puede revisar las diferencias en pantalla, comentarlas y aceptarlas con un solo clic.
- **Repositorio (_Repo_):** Es el equivalente a una «carpeta compartida inteligente» del departamento o de la asignatura. A diferencia de una carpeta corriente de Windows o de Drive, el repositorio guarda no solo los documentos actuales, sino también toda su historia: quién aportó cada párrafo, cuándo se corrigió y cómo era el texto el curso anterior.
- **Texto plano (`.md`, Markdown):** Archivos que contienen únicamente palabras y signos de puntuación estándar, sin códigos ocultos ni formatos invisibles. Se pueden abrir y leer en cualquier dispositivo, hoy o dentro de cincuenta años, sin depender de un programa de pago.
- **Typst:** Una herramienta moderna de composición tipográfica que sustituye la maquetación manual. El profesor se limita a escribir las explicaciones y las fórmulas matemáticas; el sistema calcula los saltos de página, los márgenes y las tipografías de forma automática para que el cuadernillo salga perfecto por la impresora.
- **Zotero:** Un organizador bibliográfico personal que funciona como una biblioteca de bolsillo. Permite guardar libros, páginas web o artículos académicos con un solo clic desde el navegador, ordenando autores, fechas y títulos para citarlos después en los apuntes sin tener que teclear fichas a mano.