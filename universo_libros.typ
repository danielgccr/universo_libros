#set terms(hanging-indent: 1.5em)

#set table(
  inset: 6pt,
  stroke: none
)

#let horizontalRule = line(start: (25%,0%), end: (75%,0%))
// Polyfill divider to allow compiling with typst < 0.15:
#let divider = if "divider" in std { divider } else { horizontalRule }

#show figure.where(
  kind: table
): set figure.caption(position: top)

#show figure.where(
  kind: image
): set figure.caption(position: bottom)

#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}
#let conf(
  title: none,
  subtitle: none,
  authors: (),
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "Charter",
  fontsize: 12pt,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: "1.1.",
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  pagenumbering: "1",
  doc,
) = {
  set document(
    title: title,
    keywords: keywords,
  )
  set document(
      author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
    columns: cols
  )

  set par(
    justify: true,
    leading: linestretch * 0.5em,
    spacing: 2em
  )
  // 1em em-box + 0.5em leading = 150% line height
  set text(lang: lang,
           region: region,
           size: fontsize,
           top-edge: 0.75em,
           bottom-edge: -0.25em)

  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
  }

  if title != none {
    place(top, float: true, scope: "parent", clearance: 4mm, block(below: 1em, width: 100%)[
      #if title != none {
        align(center, block[
            #text(weight: "bold", size: 1.5em, hyphenate: false)[#title #if thanks != none {
                footnote(thanks, numbering: "*")
                counter(footnote).update(n => n - 1)
              }]
            #(
              if subtitle != none {
                parbreak()
                text(weight: "bold", size: 1.25em, hyphenate: false)[#subtitle]
              }
             )])
      }

      #if authors != none and authors != [] {
        let count = authors.len()
        let ncols = calc.min(count, 3)
        grid(
          columns: (1fr,) * ncols,
          row-gutter: 1.5em,
          ..authors.map(author => align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ])
        )
      }

      #if date != none {
        align(center)[#block(inset: 1em)[
            #date
          ]]
      }

      #if abstract != none {
        block(inset: 2em)[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
        ]
      }
    ])
  }
  doc
}
#show: doc => conf(
  title: [Un universo libre de libros y de iniciativas complicadas],
  subtitle: [Propuesta técnica, pedagógica y económica para la soberanía del material docente en centros públicos],
  authors: (
    ( name: [Daniel García],
      affiliation: "",
      email: "" ),
    ),
  lang: "es",
  abstract-title: [Resumen],
  margin: (x: 2.5cm,y: 2.5cm,),
  paper: "a4",
  fontsize: 12pt,
  linkcolor: [\#3b8ffe],
  citecolor: [\#3b8ffe],
  filecolor: [\#3b8ffe],
  pagenumbering: none,
  cols: 1,
  doc,
)

#pagebreak()
#pagebreak()
#set page(numbering: "1")

#outline(
  title: auto,
  depth: 3
);

#pagebreak()

#heading(numbering: none)[Prefacio]
<prefacio>
En España el conocimiento rara vez ha sido un bien comunal: ha funcionado como custodio y patrimonio de burócratas, gremios y despachos, véase el sangrante ejemplo de los temarios de oposiciones custodiados por academias. La tradición de conocimiento libre, que implica también debate y rendición de cuentas, no ha sido comprendida (ni querida) por parte de no pocos estamentos de la vida pública.

Incluso las nociones de lo público están viciadas: libros de texto subvencionados, pero no libres. Y se financia a empresas privadas, como el grupo Santillana, sin que repercuta en el público. Nuestro dinero engorda sus cuentas, y a cambio la información no es libre, cuando desea serlo.

Frente a dichas inercias, aquí os mostraremos instrucciones realistas, sin tener que recurrir a millonadas, de cómo ser libres en base a dos pilares tecnológicos que existen desde hace décadas y que sostienen gran parte de la infraestructura crítica del mundo moderno: el #strong[texto plano] y el #strong[control de versiones].

El #strong[texto plano] rescata la palabra escrita del secuestro de los formatos propietarios; el #strong[control de versiones] convierte la labor solitaria del docente en una construcción colectiva, acumulativa, transparente y libre de peajes.

La información (y el conocimiento) desean ser libres, y las siguientes páginas honrarán ese principio.

#pagebreak()

= Presentación

Hablan de #link("https://www.comunidad.madrid/educacion/programa-accede")[bancos de préstamo de libros], que han aliviado de verdad el bolsillo de muchas familias. Y sin embargo la letanía continúa: colas, papeleo, lotes que hay que devolver intactos, libros que no se pueden subrayar y manuales que se quedan obsoletos en cuanto cambia una ley educativa. Se ha resuelto quién paga el libro; sigue sin resolverse que el libro sea un objeto escaso, ajeno y caduco.

Así es el universo de los libros de texto en Secundaria, ¿pero y si hubiese otra forma?

La primera pieza aquí a descubrir es el #strong[texto plano]. Escribir no debería ser pelear contra márgenes que se descuadran, menús interminables o formatos cerrados que exigen pagar licencias anuales sólo para abrir un documento en condiciones. El texto plano es la esencia misma de la escritura digital: caracteres puros, sin trampa ni cartón, legibles por cualquier ordenador del planeta, hoy o dentro de cincuenta años.

#figure(image("./pics/Pasted image 20260906213536.png", alt: "Ejemplo de un editor de texto plano"),
  caption: [
    Ejemplo de un editor de texto plano
  ]
)

Adoptar este enfoque supone una liberación cognitiva para el docente. Al escribir en texto plano (usando convenciones directas como~#strong[Markdown]) se separan dos tareas que nunca debieron mezclarse: el #strong[fondo] y la #strong[forma]. El profesor se centra en estructurar las ideas, en argumentar y en enseñar; de la estética, la tipografía y el diseño final ya se encargarán las herramientas automáticas más adelante. Además, el texto plano pesa kilobytes, es mucho más resistente a la corrupción que formatos como Word (donde un fallo menor puede inutilizar el documento al completo), no oculta código basura y rescata al centro educativo de la dependencia de cualquier monopolio de software.

La segunda es el #strong[control de versiones], estándar en el desarrollo de software, ya que permite trazar cambios y tener un historial de un determinado proyecto. Para los docentes, tiene aplicaciones prácticas que, para empezar, evitan engrudos del estilo `Tema4_v2_DEFINITIVO_corregido.docx` y permiten registrar la evolución de los apuntes, más si en cada #emph[commit] se usan descripciones claras, como «Añadido el tema 4 a las notas de Lengua en 4º de la ESO: análisis sintáctico».

#figure(image("./pics/Forgejo_screenshot_dark_mode.png", alt: "Ejemplo de control de versiones"),
  caption: [
    Ejemplo de control de versiones
  ]
)

Y nos extenderemos en ambos conceptos en los siguientes apartados. El objetivo de esta lectura es no asimilar de golpe todo lo que se muestre aquí, eso sería inviable, sino tres: #strong[mostrar una alternativa viable], #strong[servir de referencia] y #strong[sembrar la curiosidad modular].

Quien lo lea con calma no necesita adoptar el paquete completo; puede empezar probando #strong[Zotero] para ordenar sus fuentes en el navegador, animarse a redactar un tema suelto en #strong[Markdown] para no pelear con Word, o descubrir que con #strong[Pandoc] un texto plano se convierte en cuadernillo en tres segundos. 

= La soberanía del texto plano

El primer cambio de paradigma consiste en despojarse del engrudo visual y de suites ofimáticas cerradas como Microsoft Office, pasando al #strong[texto plano]. Escribir no es maquetar. Cuando los profesores adoptan el texto plano, e.g., a través de #strong[Markdown], la atención está en el contenido.

- En el día a día, la opción más sencilla e intuitiva es #strong[Markdown], viable en cualquier ordenador e incluso móviles, con numerosos editores como Obsidian, MarkText o Ghostwriter. La ventaja es que Markdown puede trasladarse a numerosos formatos como HTML o PDF.
- #strong[Hablemos de rigor científico y tipográfico]: las fórmulas matemáticas tampoco obligan a salir de Markdown. Basta encerrarlas entre dobles signos de dólar para que ocupen su propia línea, o entre uno solo para intercalarlas en mitad de un párrafo. Escribiendo `$$x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}$$` se obtiene, ya compuesta, $x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a)$. El docente emplea la notación matemática estándar —la que LaTeX popularizó hace décadas—, pero no necesita instalar LaTeX ni aprender su maquinaria: al compilar, Pandoc traduce la fórmula y Typst la compone. Conviene fijar aquí, de una vez, el reparto de tareas que sostiene todo lo demás: #strong[el docente escribe siempre en Markdown; Typst es el motor que compone, y vive en la plantilla del departamento, no en el teclado del profesor.] Un profesor de Lengua no tiene por qué saber que Typst existe, igual que no necesita saber qué hace una imprenta para escribir un libro. Quien mantiene esa plantilla —el par de docentes dinamizadores de cada departamento— sí trabaja con ella, y es ahí donde se decide la coherencia visual de todos los cuadernillos del centro.

Y merece la pena contar por qué se propone justamente esta división, porque no es teórica: este documento se redactó primero en Markdown y acabó pasándose a Typst al toparse con su techo en las tablas comparativas y en la composición de la bibliografía. Ese techo existe y es honesto reconocerlo. La conclusión, sin embargo, no es que los profesores deban escribir en Typst, sino exactamente la contraria: que ese salto lo dé una sola persona, una sola vez, en la plantilla, y que los demás no lleguen a enterarse.

- Por último, el #strong[rigor bibliográfico] se completa diciéndole adiós a los enlaces rotos pegados a mano a pie de página. Mediante herramientas estándar y abiertas como #strong[Zotero] (con su conector para el navegador web, #link("https://www.zotero.org/download/")[Zotero Connector]) o #strong[JabRef], capturar una fuente de internet, un artículo o una ley en el BOE cuesta un solo clic. La extensión #emph[Better BibTeX] mantiene sincronizado automáticamente un archivo `referencias.bib` en segundo plano. Los docentes solo tienen que invocar la cita en su texto plano con una clave sencilla como `[@garcia2024]` y el sistema maquetará la bibliografía con precisión académica al compilar.

#figure(image("./pics/sidebar-view-marktext.png", alt: "Un editor en Markdown"),
  caption: [
    Un editor en Markdown
  ]
)

Y podemos dar razones para usar Markdown como el formato por defecto.

- Fácilmente portable a cualquier lado. Bajo riesgo de corrupción de datos.
- Perdurará años, incluso generaciones.
- Puede ser transformado a numerosos formatos con unos pocos comandos, ahorrando tiempo a la larga.
- Puede combinarse con un sistema de control de versiones y trazar rápidamente cualquier cambio.
- Puede ser el sustento de vuestras páginas web.
- ¡No te saldrás del teclado escribiendo, deja que fluyas!
- No dependerás de programas especiales.
- Legible de primeras en cualquier editor de texto.

= Control de versiones en las aulas
<control-de-versiones-en-las-aulas>
Si el material escolar es en texto plano, el colegio no necesita atarse a licencias privativas (sean suites ofimáticas o sistemas operativos) que secuestran los datos de los profesores, así como pagar peajes recurrentes. El colegio instala su propia instancia de~#strong[Gitea]~(o Forgejo), un entorno ético, ligero y soberano.

En este nuevo modelo:

+ #strong[Los apuntes son de código abierto:]~Los departamentos mantienen repositorios dinámicos. Un profesor puede corregir una errata y todos los estudiantes tienen la actualización al instante. El conocimiento se hereda curso a curso y se perfecciona.
+ #strong[Trabajo editorial en equipo]. Las revisiones o ampliaciones de un tema se proponen mediante ramas y revisiones (#emph[Pull Requests]), permitiendo que el departamento debata, revise y apruebe las mejoras del temario antes de consolidarlas.
+ #strong[Cambio de paradigma:]~Sin artificios, los profesores manejan conceptos como ramas, versiones, colaboración asíncrona y estructuración de datos, habilidades que forman la columna vertebral del mundo digital contemporáneo.

Este modelo también implica cambios en el paradigma. Un #strong[repositorio] es la «carpeta compartida del departamento», pero sin riesgo de que alguien borre por error el trabajo de otro.

Y conviene despejar cuanto antes dos preguntas que cualquier claustro se hará, porque de sus respuestas depende que la propuesta se reciba como una oportunidad o como una imposición.

#strong[¿Es obligatorio?] No, y no debería serlo nunca. La participación es voluntaria por docente y por departamento. Un profesor puede seguir preparando sus clases exactamente como hasta ahora; otro puede aportar únicamente los ejercicios de un tema; un departamento entero puede decidir que este curso no le viene bien. El Programa Accede, por lo demás, tampoco obliga a nadie: la obligación de licenciar en abierto que establece su reglamento recae sobre #emph[el material] que se acoge al programa, no sobre las personas, de modo que quien no quiera depositar el suyo sencillamente no lo deposita. Esta propuesta sólo aspira a que quien quiera colaborar pueda hacerlo sin que le cueste una tarde.

#strong[¿De quién son los apuntes que escribo?] Del docente que los escribe. La ley de propiedad intelectual regula la cesión de derechos en el marco de una relación #emph[laboral], que no es la de un funcionario, y la doctrina mayoritaria sostiene que los derechos permanecen en el autor mientras no exista cesión expresa; los derechos morales, en todo caso, son irrenunciables. Conviene decir también que se trata de terreno poco transitado: no consta jurisprudencia específica sobre materiales didácticos de profesorado de Secundaria. El propio reglamento del programa apunta en la misma dirección, puesto que #emph[pide autorización] a los autores, cosa que sólo tiene sentido si son ellos los titulares.

Y esto, lejos de ser una cautela jurídica, es un argumento a favor. Hoy los apuntes de un profesor circulan fotocopiados, sin firma y sin control, y no es infrecuente que acaben vendidos en plataformas comerciales por terceros. En un repositorio ocurre lo contrario: cada párrafo queda atribuido a quien lo escribió, con fecha, de forma permanente y verificable. #strong[Es el primer sistema que da al docente autoría reconocible sobre su propio trabajo.]

== Coordinación y el fin de la ambigüedad: el valor del~#emph[commit]

Adoptar este flujo exige romper con la vaguedad. El control de versiones no funciona por inercia técnica; funciona por disciplina comunicativa. En este entorno no hay sitio para guardar sin más. Cada actualización de los apuntes exige un mensaje de confirmación (#emph[commit]) que explique con precisión~#strong[qué se ha hecho y por qué]:

- #strong[Inaceptable por inútil:]~`cambios`,~`corregido`,~`archivo nuevo`,~`subiendo tarea`.
- #strong[Informativo y pedagógico:]~«Añadido el tema 4 a las notas de Lengua de 4º de ESO: análisis de oraciones subordinadas sustantivas» o~«Corregidas las erratas del ejercicio 3 de Cinemática en el tema 2».

Este hábito sintetiza el trabajo docente, hace vox pópuli las revisiones entre compañeros de departamento y convierte el historial del repositorio en una crónica pedagógica viva, estructurada y legible.

== Domesticar la fricción: cero terminales para el día a día

Cualquier propuesta que ignore la comodidad humana está condenada al fracaso. Si para participar los docentes tuvieran que generar pares de claves SSH, configurar túneles o memorizar comandos en consolas de texto, el proyecto moriría la primera semana. La experiencia de redacción y publicación debe ser accesible e intuitiva:

- #strong[Conexión transparente sin SSH:]~La sincronización con Gitea o Forgejo se realiza mediante~#strong[HTTPS]. El sistema operativo almacena las credenciales educativas de forma segura la primera vez; a partir de ahí, el intercambio de datos es automático e invisible para el usuario.
- #strong[Organización clara por carpetas:] Cada departamento dispone de su estructura en disco local (por ejemplo: `Material_Docente/Lengua_4ESO/`). Se redacta en el editor habitual y las herramientas visuales detectan los archivos modificados.
- #strong[La maquetación no se instala: ocurre en el servidor.]~Es aquí donde conviene ser radical, porque es la fuente de fricción más común y la más fácil de eliminar. En lugar de pedir a cada docente que instale Pandoc, un motor de composición y algún programa intermedio en su portátil, la conversión se configura #strong[una sola vez en el servidor del centro]. Cuando el profesor guarda sus cambios, Gitea o Forgejo ejecutan la compilación por su cuenta y depositan el PDF maquetado y la página web actualizada donde tienen que estar, sin intervención humana. El docente no instala nada, no ejecuta nada y no mantiene nada: escribe y guarda.
- #strong[Y así la plantilla del centro se cumple sola.]~Esta decisión tiene una consecuencia que va más allá de la comodidad. Si cada profesor exportara el PDF desde su propio editor, cada cuadernillo saldría con una tipografía, unos márgenes y una portada distintos, y la coherencia visual del centro sería una recomendación que nadie cumple. Al compilar en el servidor, la plantilla del departamento se aplica a todo el material por definición, y mejorarla una vez mejora de golpe todos los cuadernillos ya escritos. De paso, se resuelve un problema nada menor en equipos gestionados por la consejería: nada que instalar significa nada que pedir al servicio informático, ninguna advertencia de seguridad que esquivar y ningún programa que desaparezca al reiniciar un aula congelada.
- #strong[Con una salida de emergencia.]~Para una prueba rápida, o si el servidor no está disponible, editores como MarkText u Obsidian permiten exportar a PDF con un clic. Sirve para revisar un borrador; conviene no usarlo para lo que va a reprografía, porque ese PDF no lleva la plantilla del centro ni la bibliografía compuesta.

= Reutilizar lo que ya existe: la infraestructura pública olvidada

No hace falta reinventar la rueda ni solicitar partidas presupuestarias extraordinarias. En prácticamente todas las comunidades autónomas, las consejerías de educación ya proporcionan a cada centro un~#strong[servidor web institucional, espacio de almacenamiento, dominios oficiales y cuentas corporativas]~para docentes y alumnos.

El texto plano y los sitios estáticos son la vía más eficiente para aprovechar estos recursos:

- #strong[Cero sobrecarga técnica:]~Una web generada a partir de Markdown no depende de pesadas bases de datos que colapsan ante el tráfico simultáneo de cientos de familias. Es HTML puro: vuela, consume una fracción ínfima de ancho de banda y carga de forma instantánea incluso con conexiones móviles modestas.
- #strong[Integración inmediata:]~No se reemplaza la web institucional; simplemente se añade una subsección (`/apuntes`) donde se despliegan automáticamente los temarios actualizados tras cada revisión del departamento.
- #strong[Identidad unificada:]~Los directorios institucionales ya existentes (LDAP corporativo) se enlazan de forma directa con Gitea o Forgejo para evitar duplicar credenciales.

Pero la infraestructura olvidada no es sólo técnica. Existe también una infraestructura #strong[jurídica y presupuestaria] que ya está en pie y que casi nadie utiliza, y conviene enunciarla con precisión porque cambia por completo el tono de esta propuesta: no se está pidiendo una ley nueva, sino aplicar la que hay.

El Reglamento del Programa Accede @decreto_168_2018, que en Madrid regula el préstamo de libros, dice cuatro cosas que sostienen todo este documento:

+ #strong[Un centro puede prescindir de los libros comerciales.] Su artículo 3.1 permite expresamente adoptar materiales de elaboración propia «en sustitución de los libros de texto y material curricular comercializados, para todas o algunas» de las materias, conforme al proyecto educativo. No hace falta autorización previa ni permiso de nadie.
+ #strong[Y el programa los financia igual.] El artículo 7.1 y las órdenes que fijan las cuantías @orden_2476_2025 no distinguen: se financian los materiales «ya sean comercializados o de elaboración propia». El dinero que hoy compra manuales puede pagar la reprografía de los cuadernillos.
+ #strong[Los materiales propios no quedan congelados.] Mientras que un libro comercial no puede sustituirse durante cuatro cursos, el artículo 6.2 exime expresamente de ese plazo a los materiales de elaboración propia. Es decir: la ley concede al material vivo justo la libertad que le niega al manual impreso.
+ #strong[Y prevé cómo se comparten.] El artículo 4.1 exige, a cambio, que se licencien como recursos educativos abiertos, que identifiquen a su autor y que se depositen en la mediateca autonómica a disposición de los demás centros.

Léase de corrido y se verá que la administración lleva años describiendo, en su propio boletín oficial, un modelo muy parecido al que aquí se propone: materiales propios, abiertos, compartidos entre centros y pagados con fondos públicos. Lo que falta no es la norma ni el dinero: son las herramientas para que un claustro pueda escribir, revisar y publicar sin que la tarea se vuelva inabordable. De eso trata el resto de este documento.

== Una objeción legítima: los repositorios que ya existen
<repositorios-existentes>
Llegados aquí, cualquiera con experiencia en la administración educativa formulará la objeción evidente: esto ya se ha intentado. España lleva años construyendo repositorios de recursos educativos abiertos —Procomún del INTEF, la mediateca de EducaMadrid, el proyecto EDIA del CEDEC @cedec_edia, Agrega en su día, y sus equivalentes en varias comunidades—. Y son catálogos considerables: Procomún declara más de ochenta mil recursos.

Conviene responder con honestidad, empezando por lo que no se puede afirmar. #strong[No hay datos para sostener que esos repositorios hayan fracasado.] Ninguno publica cifras de uso: se publican contadores de objetos depositados y de usuarios registrados, que no es lo mismo que gente utilizándolos. Tampoco existe evaluación ni auditoría alguna que los examine. La única cifra de adopción que alguien ha llegado a imprimir es la del propio CEDEC —«más de treinta centros» en once comunidades autónomas— para un programa que funciona desde 2014.

Así que la pregunta no se plantea aquí como acusación, sino como lo que es: #strong[nadie sabe cuánto se usan, y esa debería ser la primera pregunta antes de invertir un euro más], incluida esta propuesta. Dicho lo cual, hay tres diferencias concretas que merecen exponerse.

+ #strong[La unidad de contribución.] Un repositorio de REA admite obras terminadas: para participar hay que producir una unidad didáctica completa, con su guía y sus rúbricas. Contribuir es, por tanto, emprender un proyecto. Un sistema de control de versiones admite algo radicalmente distinto: la corrección de una sola frase. Y eso importa, porque el obstáculo documentado no es la falta de voluntad sino la falta de tiempo: en Secundaria, sólo el 46% del profesorado español intercambia materiales didácticos con sus compañeros y en torno al 30% participa en plataformas en línea con ese fin @talis_2018_colaboracion. Bajar el precio de entrada de «una unidad didáctica» a «una errata» no es un detalle técnico: es la diferencia entre participar y no hacerlo.
+ #strong[Resuelve un problema que existe hoy.] No es una mejora hipotética. Como se verá al hablar de precedentes, el mayor proyecto colaborativo de libros de texto de España tiene ahora mismo versiones bifurcadas en Murcia y en valenciano que no pueden reintegrarse al original porque se distribuyen como archivos sueltos. Ese problema no lo resuelve un catálogo: lo resuelve el control de versiones.
+ #strong[Y no basta con la herramienta.] Ésta es la lección que ningún repositorio parece haber aprendido, y que conviene no repetir: una plataforma sin nadie encargado de sostenerla es un almacén vacío. Se volverá sobre ello, pero adelantémoslo: la diferencia entre los proyectos abiertos que prosperan y los que se apagan casi nunca es el software.

= El límite del objeto físico: del cupo a la abundancia

Los bancos de préstamo de libros son una buena política, y conviene decirlo sin reservas antes de señalar sus límites: han retirado de la cuesta de septiembre un gasto que asfixiaba a muchas familias, y en Madrid cubren ya en torno a dos de cada tres alumnos de la enseñanza obligatoria. El problema no está en el programa, sino en aquello que el programa se ve obligado a administrar: #strong[un objeto físico, limitado, que hay que repartir, vigilar, reponer y devolver]. De ahí se derivan unas cuantas fricciones que cualquier equipo directivo reconocerá:

- #strong[La logística de septiembre:]~El acceso no depende de la renta —conviene desmentirlo, porque se repite mucho: el baremo de la participación no es por criterios socioeconómicos—, sino de un requisito material: devolver en junio el lote completo y en buen estado. Basta con que falte o se estropee un ejemplar para que la familia tenga que reponerlo o quede fuera del reparto. A eso se suman los retrasos, documentados en Madrid en cursos consecutivos, con lotes llegando en octubre a las aulas, y la fianza de entre cinco y sesenta euros que los centros pueden exigir. Nada de esto es un defecto de intención: es lo que cuesta mover cientos de miles de objetos cada verano.
- #strong[Obsolescencia forzada por cambio editorial:]~Cuando un departamento decide cambiar de editorial o se renueva el currículo legal, cientos de libros en perfecto estado físico van directamente a la basura porque no coinciden con la nueva edición comercial.
- #strong[El libro intocable:]~El alumno no puede subrayar, resolver actividades en los márgenes ni apropiarse del material porque la penalización por deterioro le excluye del banco de libros del curso siguiente.

El texto plano y la impresión a demanda no vienen a sustituir el propósito del préstamo, sino a #strong[llevarlo hasta el final]: si lo que se persigue es que ningún alumno se quede sin material, el modo más barato y más seguro de conseguirlo es que el material deje de ser escaso.

- #strong[Nulo coste marginal:]~Un archivo Markdown no se desgasta, no ocupa espacio en un almacén y copiarlo para cien o mil estudiantes apenas cuesta.
- #strong[Abundancia inmediata:]~No existe el concepto de «quedarse sin libro». Si a mitad de curso llega un alumno, su temario está disponible en la web del centro desde el primer instante y su cuadernillo sale de la reprografía en tres minutos.
- #strong[Fin de la fiscalización del desgaste:]~Las familias y los docentes se liberan del tiempo invertido en revisar páginas selladas, borrar anotaciones a lápiz o tramitar expedientes de fianza en secretaría. El material en papel deja de ser un activo patrimonial que vigilar y vuelve a ser lo que siempre debió ser: una herramienta de estudio viva, económica y libre para anotar.

== Un solo origen: web ligera y papel a demanda
<un-solo-origen-web-ligera-y-papel-a-demanda>
Rechazar el modelo editorial tradicional no implica rendirse a la tiranía de la pantalla permanente. El papel sigue y seguirá siendo un soporte insustituible para la concentración, la lectura profunda y el estudio libre de distracciones.

La ventaja del texto plano es que actúa como una~#strong[fuente única de la verdad]. A partir de los mismos archivos en el repositorio, la automatización genera dos salidas inmediatas:

+ #strong[Una web sencilla y ligera:]~Alojada en la propia infraestructura del centro, accesible desde cualquier navegador, rápida y libre de rastreadores.
+ #strong[Documentos PDF listos para imprimir a demanda:]~Cuadernillos maquetados con elegancia tipográfica que los alumnos o el centro pueden imprimir por temas según se vayan impartiendo.

La diferencia frente al manual de trescientas páginas del banco de libros es sustancial: el cuadernillo impreso a demanda es un material vivo y fungible. El alumno lo puede subrayar, anotar en los márgenes, completar sus ejercicios y conservarlo como su propio cuaderno de aprendizaje.

Conviene aclarar aquí que #strong[qué se imprime no lo decide este documento, sino cada departamento], y que la herramienta no obliga a nada. Un departamento puede limitarse a un cuadernillo de trabajo —ejercicios, esquemas, mapas mudos, actividades— y dejar la explicación en la web o en la voz del profesor. Otro puede aspirar a un temario completo, con la exposición redactada íntegramente, como llevan años haciendo los libros de Marea Verde @mareaverde. Y lo más probable es que dentro de un mismo claustro convivan ambas cosas, y que una materia empiece por lo primero y acabe en lo segundo con los años.

Hay además una tercera salida, menos evidente y probablemente la más valiosa. Del mismo fichero pueden generarse #strong[versiones adaptadas], y sale prácticamente gratis: el mismo tema con cuerpo de letra mayor, con más interlineado, con una tipografía pensada para lectores con dislexia, en alto contraste o sin las imágenes decorativas que distraen. Donde una editorial ofrece una edición adaptada —cuando la ofrece— y la cobra aparte, aquí basta con volver a compilar el mismo texto con otra plantilla.

Conviene subrayarlo porque la atención a la diversidad no es un adorno, es una obligación legal, y suele ser la primera pregunta de cualquier jefatura de estudios. El argumento del coste marginal nulo, que en el apartado siguiente se aplica al papel, vale sobre todo aquí: preparar el material del alumno con dificultades de lectura deja de ser un trabajo aparte, hecho a mano y a última hora, para convertirse en una opción más de la misma fuente. Y en la salida web ocurre algo parecido: una página construida a partir de texto plano es lo que mejor saben leer los lectores de pantalla, justo lo contrario que un PDF escaneado, que para un lector automático es una fotografía muda.

Esa decisión tiene una consecuencia económica directa que conviene tener presente al leer las cuentas del apartado siguiente: la cifra que allí se maneja corresponde al caso más exigente, el del temario completo. Un cuadernillo de trabajo cuesta imprimir tres o cuatro veces menos, y carga a la reprografía del centro en la misma proporción. El modelo no impone un formato: pone los medios, y el criterio pedagógico sigue siendo del departamento.

== Qué puede publicarse en abierto y qué no
<dos-niveles>
Hay un punto en el que conviene no improvisar, porque es el que con más facilidad puede dar al traste con todo el proyecto: no todo lo que un profesor usa en clase puede colgarse después en la web del centro.

La legislación distingue con nitidez dos situaciones que en la práctica docente se confunden a diario. Repartir en clase un fragmento breve, una fotografía o un esquema ajenos está amparado por el límite de ilustración de la enseñanza que reconoce la Ley de Propiedad Intelectual —con la salvedad, nada menor, de que ese límite excluye expresamente los libros de texto y manuales—. Pero la normativa que regula el uso digital con fines educativos exige que esos actos ocurran en un «entorno electrónico seguro», es decir, con acceso restringido al alumnado y al profesorado del centro. Una web abierta al mundo no lo es. Y el propio Decreto 168/2018 @decreto_168_2018 lo dice sin rodeos: los materiales de elaboración propia que incorporen obra ajena no pueden reproducirse sin licencia abierta o autorización expresa del titular.

Dicho de otro modo: el permiso que ampara la fotocopia de aula #strong[se evapora] en el momento en que ese mismo archivo se publica en abierto. La solución no es renunciar a publicar, sino separar dos niveles desde el primer día, cosa que cualquier instancia de Gitea o Forgejo permite sin esfuerzo, porque distingue de forma nativa entre repositorios públicos y privados:

+ #strong[Nivel público.] Material íntegramente propio o construido con obra de licencia compatible. Se publica en la web del centro, se imprime en reprografía y se deposita en la mediateca autonómica. Es el que sostiene todo lo dicho en los capítulos anteriores.
+ #strong[Nivel de aula, autenticado.] Material amparado por el límite de enseñanza: recortes de prensa, fotografías ajenas, láminas, textos literarios completos. Accesible sólo con las credenciales educativas del centro. Aquí es también donde deben vivir los comentarios del alumnado, por tratarse de datos de menores.

Para que la distinción no dependa del criterio de cada cual, conviene que el departamento trabaje con una lista de comprobación sencilla. Puede ir al nivel público:

- #strong[Sí:] el texto redactado por el propio docente, y los esquemas, tablas y gráficos que elabore.
- #strong[Sí:] las imágenes de dominio público o con licencia CC0 —el fondo de Wikimedia Commons es inmenso—, que además pueden recortarse, traducirse y adaptarse libremente.
- #strong[Sí:] las imágenes con licencia CC BY-SA, siempre que se usen sin modificar y lleven su propio pie con autor, procedencia y licencia.
- #strong[No:] la fotografía de prensa, la lámina escaneada de un manual comercial, el poema o el capítulo íntegros, la ilustración encontrada en un buscador.
- #strong[No:] cualquier imagen en la que aparezcan menores identificables.

Merece la pena reconocer una cosa al hacer este trabajo, porque refuerza el argumento en vez de debilitarlo: gestionar derechos de imagen y de texto es precisamente uno de los servicios invisibles que las familias están pagando cuando compran un manual comercial. Asumirlo cuesta disciplina; ignorarlo cuesta un disgusto.

== Las cuentas del sistema: comprar una vez o alquilar para siempre
<las-cuentas-del-sistema>
No existen las comidas gratis. Que una familia acogida al Programa Accede no pague nada en septiembre no significa que los libros salgan gratis: significa que ya los ha pagado antes, por la vía del impuesto, y que los seguirá pagando cada curso mientras el modelo siga en pie. La pregunta honesta, por tanto, no es cuánto se ahorra una familia concreta, sino #strong[qué le cuesta al sistema en su conjunto cada una de las dos alternativas].

Y para responderla hay que corregir antes una comparación tramposa que se hace a menudo, empezando por este documento en versiones anteriores. El precio de un lote de libros no es un gasto anual: un banco de préstamo se reutiliza. Su coste por curso es el coste amortizado, no el de compra. En la Comunidad de Madrid, la creación de un lote completo de ESO se fijó en 270 € por alumno @orden_3616_2019, los materiales no pueden sustituirse antes de cuatro cursos @decreto_168_2018 y la reposición ordinaria por deterioro o extravío se presupuesta en torno al 10% anual @orden_2476_2025. Un cuadernillo impreso, en cambio, es fungible: se consume entero cada curso y no amortiza nada.

Puestas ambas cosas en la misma unidad —coste público anual por alumno de ESO— y tomando como referencia las tarifas públicas de reprografía @unizar_precios_2024 @uniovi_tarifas_reprografia, el resultado es este:

#figure(
  align(center)[#table(
    columns: (34%, 33%, 33%),
    align: (left, left, left),
    table.header([Concepto], [Banco de préstamo comercial], [Texto plano e impresión a demanda],),
    table.hline(),
    [Creación o renovación del material], [270 € por alumno en cada renovación], [Unos 200.000 € una sola vez para toda la ESO de la región: menos de 1 € por alumno],
    [Consumo o reposición anual], [\~28 € por alumno], [\~40 € por alumno (cuadernillo B/N, fungible)],
    [#strong[Coste anual si se renueva cada 4 cursos]], [#strong[\~95 €]], [#strong[\~41 €]],
    [#strong[Coste anual si se renueva cada 8 cursos]], [#strong[\~62 €]], [#strong[\~41 €]],
    [Coste anual si no hubiera que renovar nunca], [\~28 €], [\~41 €],
    [Titularidad del material al cabo de una década], [Ninguna], [Íntegra, actualizada y reutilizable],
  )]
  , kind: table
  )

Las cifras de redacción son una estimación prudente y conviene explicitarla: unas doscientas horas de trabajo docente por materia y curso, retribuidas a precio de hora completa, dan alrededor de 200.000 € para cubrir las ocho materias de los cuatro cursos de la ESO. Aunque se multiplicara por diez, seguiría siendo calderilla repartida entre los cerca de 250.000 alumnos de ESO de la región.

Conviene leer la tabla con cuidado, porque dice tres cosas y sólo dos favorecen a esta propuesta.

- #strong[En un mundo estable, el préstamo gana.] Si el currículo no cambiara jamás y los libros no se estropearan, mantener un banco costaría unos 28 € por alumno y curso, menos que los 40 € de imprimir. Hay que decirlo: la ventaja del modelo abierto no está en el precio de la fotocopia.
- #strong[La variable decisiva es cada cuánto hay que volver a comprarlo todo.] Y ahí el modelo comercial es rehén de una legislación educativa que cambia cada pocos años. Cada reforma curricular manda al contenedor cientos de libros en perfecto estado y reinicia los 270 € desde cero, mientras que al material propio le cuesta lo que cueste editarlo. A esto se añade una asimetría legal que juega a favor: los materiales comercializados no pueden sustituirse durante cuatro cursos, pero los de elaboración propia están expresamente exentos de esa congelación.
- #strong[Y sobre todo: al cabo de diez años, uno de los dos modelos ha comprado algo.] Aquí está el argumento de fondo, y no es una cuestión de céntimos por página. La administración destina hoy decenas de millones de euros cada año a licencias temporales y manuales cerrados, y transcurrida una década #strong[no es propietaria de una sola línea de texto]. Alquila, de forma indefinida, un material que tendrá que volver a alquilar. La redacción de materiales propios, en cambio, es una inversión de capital: crea un activo público, de titularidad regional, reutilizable sin coste marginal, que en lugar de caducar mejora cada curso con las correcciones de quienes lo usan.

Hay además una serie de costes que el precio del lote no refleja nunca y que soporta el centro: la recogida y revisión de ejemplares en junio, las fianzas, los expedientes por deterioro, el almacenaje, la exclusión de la familia que devuelve un lote incompleto y los retrasos documentados en la entrega, con lotes llegando en octubre. Y una diferencia que cualquier jefe de estudios reconocerá al instante: el coste marginal del alumno que se incorpora en febrero es de 270 € —o de quedarse sin libros— en un modelo, y de cincuenta céntimos en el otro.

En sentido contrario, y para que el balance sea honesto, hay tres costes que esta propuesta debe apuntar en su propia columna y que no aparecen en la tabla: las horas de redacción y coordinación del profesorado, que sólo se diluyen si el material se comparte a escala autonómica; el mantenimiento de la infraestructura técnica, modesto pero no nulo; y la carga real sobre la reprografía del centro, que con ochenta temas por alumno y curso deja de ser una tarea rutinaria para convertirse en un volumen de producción que hay que planificar.

#strong[¿Y la familia?] En un centro acogido a Accede, cero euros en ambos modelos, porque el programa financia por igual los materiales comercializados y los de elaboración propia. Fuera de Accede —otras comunidades, centros no adheridos, o el curso en que un lote se rechaza por incompleto— la diferencia es la que ya se ha visto: unos 40 € repartidos a lo largo del año frente a un desembolso de entre 200 y 270 € en la primera quincena de septiembre @ocu_vuelta_cole @anele_informe. Y con una ventaja que no aparece en ninguna tabla: el cuadernillo se subraya, se anota y se conserva.


= Precedentes: lo que ya funciona y lo que ya falló
<precedentes>
Antes de proponer nada conviene mirar lo que otros ya han hecho, incluidos sus fracasos. Existen precedentes sólidos de materiales docentes abiertos que duran décadas, de claustros enteros que redactan sus propios libros y de proyectos que, pese a la financiación y al entusiasmo, se quedaron por el camino. Los casos siguientes acotan con bastante precisión qué está demostrado y qué no.

== Un solo docente, veinte años: MC Libre
<mc-libre>
Lejos de ser una hipótesis teórica, este enfoque cuenta con precedentes de enorme éxito y longevidad en el sistema educativo español. Un ejemplo paradigmático es el portal pedagógico #strong[mclibre.org] @mclibre, desarrollado por el profesor Bartolomé Sintes Marco.

#figure(image("./pics/Pasted image 20260906214415.png", alt: "McLibre"),
  caption: [
    Página principal de McLibre
  ]
)

Durante más de veinte años, miles de alumnos y docentes de Secundaria, Bachillerato y Formación Profesional han utilizado sus materiales didácticos, los cuales comparten los mismos pilares de esta propuesta:

- #strong[Formatos abiertos e interoperables:] Materiales construidos en estándares web abiertos, ligeros y descargables íntegramente para funcionar sin conexión si el aula de informática se queda sin red.
- #strong[Independencia absoluta de proveedores:] Ninguna empresa editorial ni multinacional tecnológica intermedia entre el docente y el contenido. El conocimiento se actualiza curso a curso a demanda de las necesidades pedagógicas reales, no de calendarios comerciales de reedición.
- #strong[Licencias libres y reutilización:] El material se publica bajo licencias Creative Commons, de modo que cualquier docente puede copiarlo, adaptarlo y redistribuirlo sin pedir permiso ni pagar peaje alguno.

Conviene precisar qué demuestra este precedente y qué no. MC Libre es la obra sostenida de un solo docente que publica, no el trabajo coordinado de un departamento: acredita que unos materiales abiertos, en formatos universales, duran décadas, se mantienen al día y sirven a miles de alumnos sin intermediación editorial ni caducidad comercial. Es una prueba de longevidad y de viabilidad, no de flujo colaborativo.

== Un claustro entero: Apuntes Marea Verde
<marea-verde>
Si MC Libre acredita la longevidad, #link("https://www.apuntesmareaverde.org.es/")[#strong[Apuntes Marea Verde]] @mareaverde acredita la autoría colectiva. Desde 2011, un grupo de docentes de la escuela pública madrileña redacta y comparte libros de texto completos y gratuitos. Hoy cubre trece departamentos —Matemáticas, Lengua y Literatura, Física y Química, Geografía e Historia, Tecnología, Economía, Música, Clásicas y otros— desde 1.º de la ESO hasta 2.º de Bachillerato, con los diez volúmenes de Matemáticas ya actualizados al currículo LOMLOE.

Lo decisivo no es el catálogo, sino el método. Cada capítulo se publica con dos nombres al frente: #emph[Autor] y #emph[Revisor]. Un solo libro de 1.º de la ESO reúne una quincena de autores y media docena de revisores. Dicho de otro modo: Marea Verde lleva quince años practicando #strong[la revisión por pares antes de publicar], que es exactamente el principio que en el mundo del software se denomina #emph[Pull Request], sólo que ejecutado con documentos de Word y correo electrónico. Y funciona: en 2016 el sitio registró cerca de 260.000 visitas y sirvió seis terabytes de descargas @mareaverde_visitas, con tráfico intenso desde México, Argentina, Colombia y Perú.

El proyecto es además honesto sobre sus propios límites: como las descargas son libres y no exigen registro, sus responsables reconocen abiertamente que desconocen qué centros y qué comunidades autónomas utilizan sus libros.

Pero hay un detalle en su web que justifica por sí solo esta propuesta. Junto al libro de 1.º de la ESO figura un segundo archivo, `Murcia_1eso.pdf`, acompañado de esta nota: «Los compañeros de la Comunidad Autónoma de Murcia han adaptado el libro a su programa, diferente del de Madrid». Existe también una traducción íntegra al valenciano realizada por profesores del IES Juan de Garay.

Eso es, literalmente, una bifurcación: un #emph[fork] docente como el que se describía en el capítulo anterior. Pero al estar hecha copiando y editando ficheros sueltos, es una bifurcación sin retorno: cada errata que Murcia corrige se pierde para Madrid, y cada mejora madrileña obliga a rehacer el trabajo a mano en la versión valenciana. #strong[El mejor proyecto colaborativo de libros de texto de España tiene, hoy mismo, un problema de fusión de versiones que las herramientas que emplea no pueden resolver.] No hace falta imaginar para qué serviría el control de versiones en la Secundaria española: basta con mirar Marea Verde.

== La escala nacional: Sésamath y Lelivrescolaire
<escala-nacional>
Francia demuestra que el modelo escala mucho más allá de un grupo de voluntarios. #link("https://www.sesamath.net/")[#strong[Sésamath]] @sesamath, asociación de profesores de Matemáticas activa desde 2001, publica manuales redactados por entre setenta y cinco y cien docentes en activo, distribuidos gratuitamente en digital y financiados mediante la venta de las ediciones en papel. Su trabajo obtuvo una mención del Premio UNESCO Rey Hamad Bin Isa Al-Khalifa en 2007.

#strong[Lelivrescolaire.fr] @lelivrescolaire, nacido en 2009, ha ido aún más lejos: alrededor de cuatro mil profesores han contribuido a alguna de sus colecciones. Una sola de ellas reunió, en nueve meses, a cuatrocientos docentes que aportaron treinta mil contribuciones repartidas en diez manuales y cuatro mil páginas.

Conviene subrayar un matiz técnico, porque juega a favor y en contra a la vez: ninguno de los dos emplea control de versiones. Ambos se construyeron plataformas web propias de redacción. Eso prueba dos cosas simultáneamente: que la autoría colectiva a escala nacional es perfectamente posible, y que la herramienta importa lo bastante como para que estos proyectos invirtieran años en fabricarse una a medida. La diferencia hoy es que esa herramienta ya no hay que construirla: Gitea y Forgejo son software libre, maduro y gratuito.

== El modelo de las universidades punteras: el estándar abierto
<el-modelo-de-las-universidades-punteras-el-estándar-abierto>
En la educación superior internacional más exigente, el manual comercial tradicional es un anacronismo. Cursos de referencia global como el #link("https://web.stanford.edu/class/cs224n/")[#strong[CS224N de la Universidad de Stanford]] (o la red de cursos abiertos del MIT OpenCourseWare) demuestran cómo la docencia puntera se estructura en torno a la apertura técnica:

- Webs estáticas ultra-ligeras alojadas en servidores propios institucionales.
- Apuntes (#emph[lecture notes]) redactados directamente por el profesorado en texto plano (LaTeX/Markdown) y compilados a PDF impecables.
- Dinamismo pedagógico: si un concepto evoluciona o un ejercicio genera dudas recurrentes, el cambio se incorpora esa misma tarde en el repositorio del curso.

La comparación tiene límites y conviene enunciarlos: esos cursos se dirigen a estudiantes adultos, no responden ante un currículo legalmente prescrito y disponen de equipos de ayudantes que ningún departamento de instituto tiene. Lo que sí acreditan, y no es poco, es que en la cima académica los materiales abiertos en texto plano bastan para enseñar materias de enorme exigencia técnica sin manual comercial de por medio.

Resulta contradictorio que, mientras la vanguardia académica internacional enseña mediante recursos abiertos, trazables y dinámicos, la Educación Secundaria española permanezca atada a los ciclos comerciales de reedición de editoriales privadas.

== Git fuera de la informática: The Programming Historian
<programming-historian>
Queda por responder la objeción más previsible de todas, y conviene hacerlo con un ejemplo antes que con un argumento: «el control de versiones es cosa de programadores, un departamento de Lengua nunca va a usar eso».

#link("https://programminghistorian.org/")[The Programming Historian] @programming_historian lleva dieciocho años demostrando lo contrario. Es una revista de acceso abierto con revisión por pares que publica tutoriales de humanidades digitales, sostenida por una entidad sin ánimo de lucro y un consejo editorial de unas cuarenta personas. Reúne alrededor de doscientas cincuenta lecciones en cuatro idiomas y, según sus propias cifras, unos dos millones de lectores al año. Su #strong[edición en castellano existe desde 2017], cuenta con equipo editorial propio —lingüistas, historiadores, filósofos y bibliotecarios de universidades españolas y latinoamericanas— y ronda las setenta lecciones publicadas, en su mayoría traducciones y una veintena de originales.

Lo revelador es cómo funciona por dentro, porque es casi exactamente el modelo que este documento propone. Las lecciones son ficheros Markdown en un repositorio público. La revisión por pares no ocurre por correo ni en una plataforma editorial cerrada: cada propuesta abre un ticket público en el repositorio, donde los revisores comentan a la vista de todos, el autor responde y el editor aprueba, siguiendo un flujo documentado de ocho fases y un mínimo de dos revisores. Y quienes lo sostienen no son ingenieros de software, sino historiadores, filólogos, archiveros y bibliotecarios.

Ahora bien, este precedente enseña además algo incómodo que sería deshonesto saltarse, y que resulta ser la lección más útil de todas. El propio proyecto la publicó en un artículo cuyo título lo resume: #emph[Relocating Complexity] @lincoln_relocating_complexity, reubicar la complejidad. Su tesis es que un modelo así no elimina la dificultad técnica: la traslada, y alguien tiene que absorberla. En The Programming Historian ese alguien tiene nombre y cargo —una responsable de publicación, retribuida, cuyas aportaciones al repositorio suponen por sí solas más de una cuarta parte del total— y existen convenciones expresas para proteger a los demás: el autor redacta en Markdown y se lo envía por correo al editor, y es el editor quien lo sube y abre el ticket de revisión. El autor sólo necesita entrar para responder a los comentarios.

La conclusión que importa a un instituto es doble y hay que enunciarla entera. La primera mitad es alentadora: no hace falta ser informático para trabajar así, y hay dieciocho años, cuatro idiomas y una edición en castellano que lo prueban. La segunda es una advertencia presupuestaria: funciona porque hay alguien encargado de que funcione. Trasladado a un centro educativo, ese alguien es exactamente la figura del docente dinamizador y las horas de coordinación que se reclaman más adelante. No es una recomendación amable: es la condición para que todo lo demás sea cierto.

== Lo que ya falló: la lección de FHSST
<fhsst>
Sería deshonesto presentar sólo los éxitos. El proyecto sudafricano #strong[Free High School Science Texts] (FHSST) se propuso escribir libros de ciencias libres para Secundaria mediante voluntarios coordinados a través de un repositorio de control de versiones, con los textos redactados en LaTeX. Contaba con financiación, respaldo institucional y una comunidad numerosa. El resultado, documentado en un estudio del ISKME @fhsst_iskme, es aleccionador: de 682 voluntarios registrados apenas medio centenar estaban activos, y sólo una decena contribuía de forma sostenida.

Las causas que identifica el estudio merecen citarse sin adornos. Dar de alta a un voluntario en el repositorio era «un proceso laborioso» que exigía «amplios conocimientos técnicos» y acababa descargando el trabajo sobre el núcleo del equipo. La redacción en LaTeX resultó demasiado técnica y hubo que sustituirla por texto enriquecido. Las tareas del tamaño de un capítulo no se terminaban en plazo y hubo que trocearlas. Y el reclutamiento que de verdad funcionó fue el presencial, no el telemático. FHSST terminó abandonando el control de versiones y migrando a un formulario web sobre Drupal.

Ahora bien, hay que precisar qué parte de esa advertencia sigue vigente y cuál no. El repositorio de FHSST era de tipo centralizado y de una generación anterior a Git: obligaba a instalar un cliente, descargar una copia de trabajo completa y manejar comandos en consola. Una instancia de Gitea o Forgejo en 2026 no se parece a aquello: un docente puede corregir una errata desde el propio navegador, sin instalar absolutamente nada, y su propuesta de cambio queda registrada y revisable igual. La fricción concreta que hundió a FHSST ha sido, en buena medida, resuelta por ingeniería.

Lo que no ha cambiado es la parte humana, y es la que esta propuesta debe tomarse en serio: la participación seguirá una distribución muy desigual, las tareas han de ser pequeñas para que alguien las termine, y a los compañeros se les recluta hablando con ellos en la sala de profesores, no publicando un enlace y esperando.

== Qué demuestran estos precedentes y qué no
<balance-precedentes>
Conviene cerrar con el balance exacto, porque un argumento que exagera su respaldo se derrumba en la primera pregunta incómoda.

#strong[Está demostrado] que los materiales docentes abiertos pueden perdurar décadas (MC Libre), que un colectivo de profesores puede redactar libros de texto completos con revisión por pares y servirlos a cientos de miles (Marea Verde), y que el modelo escala a un país entero con cientos o miles de autores (Sésamath, Lelivrescolaire).

#strong[No está demostrado] que un claustro de Secundaria coordine su temario mediante control de versiones y propuestas de cambio: no consta ningún caso documentado en el mundo. En ámbitos vecinos sí lo hay —los materiales de #link("https://carpentries.org/")[The Carpentries] o de #link("https://the-turing-way.netlify.app/")[The Turing Way] acumulan varios cientos de contribuyentes cada uno, y su metodología está publicada en «Ten simple rules for collaborative lesson development» @carpentries_ten_rules, y a ellos hay que sumar The Programming Historian, que es el caso más cercano por tratarse de humanistas y no de informáticos—, pero en todos ellos se trata de educación superior, investigación o formación de posgrado, no de aulas de instituto.

Y esas cifras conviene leerlas con precisión, porque el titular engaña. El repositorio de lecciones más veterano de The Carpentries acumula 375 contribuyentes, pero más de la mitad de ellos aportó una única corrección y diez personas concentran el 59% del trabajo. La promesa realista, por tanto, no es «cuatrocientos coautores»: es #strong[un núcleo reducido de mantenedores más una cola larga de correcciones pequeñas]. Esa cola larga, sin embargo, es justamente lo que hoy no existe: una errata detectada en noviembre por un profesor de Cuenca no tiene ningún camino por el que llegar al material que usa un compañero de Alcorcón.

De ahí que la forma sensata de empezar no sea un despliegue autonómico, sino un #strong[pilotaje acotado]: un departamento, una materia, un curso académico y un criterio explícito para decidir si ha funcionado —por ejemplo, cuántas propuestas de cambio ajenas al autor original llegaron a integrarse, y si al terminar el curso el material seguía vivo—. Lo que aquí se propone no es repetir algo ya probado: es dar un primer paso que nadie ha dado todavía en un instituto, con la ventaja nada menor de saber de antemano dónde tropezaron quienes lo intentaron antes.

= Preguntas frecuentes para claustros y equipos directivos
<preguntas-frecuentes-para-claustros-y-equipos-directivos>

== ¿Qué personal técnico y organizativo se necesita para poner en marcha y mantener este sistema?

Una de las grandes fortalezas del texto plano y de herramientas como Gitea es que~#strong[no requieren un departamento informático dedicado ni contrataciones externas multimillonarias]. La carga de trabajo se distribuye entre perfiles que los centros de Secundaria ya tienen regulados en plantilla:

- #strong[Coordinador TIC / Responsable de Medios Informáticos (figura docente ya existente):]

  - #strong[Rol en el despliegue:]~Instalar la instancia de Gitea o Forgejo —un contenedor Docker ligero basta—, vincularla al directorio de usuarios existente (LDAP institucional) y configurar la compilación automática que genera los PDF y la web. El consumo de máquina es mínimo: el texto plano pesa kilobytes y las copias de seguridad completas ocupan unos pocos megabytes.
  - #strong[Y aquí conviene no engañar a nadie.]~Sería cómodo despachar esto como «unas pocas horas» y sería falso. Instalar es rápido; sostener no lo es. Alguien tiene que advertir que una compilación ha dejado de funcionar la semana antes de los exámenes, aplicar las actualizaciones de seguridad cuando toca y comprobar que las copias de seguridad restauran de verdad. A ello se suman dos requisitos que no son técnicos: en muchos centros la consejería no concede permisos de administración sobre el servidor institucional, de modo que la instalación pasa por una solicitud al servicio informático correspondiente; y un servicio que almacena datos de usuarios obliga a cumplir con el Esquema Nacional de Seguridad y con la normativa de protección de datos, con su registro de tratamiento y la intervención del delegado de protección de datos del centro. Nada de esto es inasumible —hablamos de un servicio pequeño y bien acotado—, pero exige #strong[horas de reducción reconocidas], no buena voluntad. Un centro que no pueda garantizarlas hará bien en leer antes la alternativa que se propone en el anexo.

- #strong[Profesorado dinamizador o «pionero» (1 o 2 docentes por departamento):]

  - #strong[Rol:]~No programan; actúan como referentes de materia. Crean las plantillas básicas del departamento (el archivo~`.bib`~base para referencias y la estructura de carpetas por temas) y resuelven dudas cotidianas a sus compañeros de claustro durante las reuniones de departamento.

- #strong[Personal de reprografía / Conserjería del centro:]

  - #strong[Rol:]~Recibir los PDF generados automáticamente e imprimirlos conforme los departamentos vayan arrancando cada unidad. La tarea es la de siempre, pero el volumen no: si un departamento opta por el temario completo, la demanda se concentra al inicio de cada tema y conviene planificarla —imprimir con unos días de margen y por grupos— en lugar de atenderla a mostrador. Un cuadernillo de trabajo, más breve, reduce esa carga a la tercera o la cuarta parte.

Al prescindir de arquitecturas complejas de bases de datos pesadas, servidores dedicados o licencias que caducan, la administración del sistema se reduce a una tarea de bajo impacto que cabe perfectamente en las horas lectivas de reducción asignadas a la coordinación tecnológica del instituto.

== ¿Cómo es el día a día del docente redactando apuntes y cómo le afecta este cambio de paradigma frente al libro comercial?

El libro tradicional actúa muchas veces como un salvavidas frente a la sobrecarga horaria y burocrática, pero en la práctica acaba siendo un corsé: se omiten temas enteros, se complementa con fotocopias sueltas y se supedita el ritmo del aula al índice de una editorial comercial. El paso al texto plano transforma la preparación de clases en una labor acumulativa y colaborativa:

- #strong[El mito del «lienzo en blanco»:]~Nadie empieza desde cero en septiembre. Se parte de materiales propios ya existentes en Word, de apuntes heredados del departamento o de Recursos Educativos Abiertos (REA) de la comunidad docente. La conversión de esos documentos también corre a cargo del servidor: basta con dejar el fichero `.docx` en la carpeta del tema para que vuelva convertido a Markdown. Ahora bien, conviene saber de antemano qué sobrevive al viaje y qué no, porque lo segundo se pierde en silencio si nadie avisa. #strong[Pasan bien] el texto corrido, los títulos —siempre que se hayan usado los estilos de Word y no negritas grandes—, las notas al pie, las imágenes y las fórmulas escritas con el editor de ecuaciones moderno. #strong[No pasan] los cuadros de texto —esos recuadros de «recuerda» y de definiciones que son el pan de cada día del material de Secundaria—, los diagramas de tipo SmartArt ni las fórmulas antiguas de MathType. Por eso la conversión del centro debe estar configurada para #strong[avisar de lo que ha dejado atrás] en lugar de entregar un documento aparentemente correcto: es mucho más barato recuperar cuatro recuadros el primer día que descubrir en febrero que faltaban. Y hay dos formatos que sencillamente no tienen conversión posible: las #strong[presentaciones] y los #strong[PDF o escaneados], que habrá que rehacer o enlazar como material adjunto.
- #strong[Trabajo en equipo real dentro del departamento:]~En el modelo editorial, cada profesor suele estar aislado en su aula con su manual. Con el control de versiones, el departamento reparte esfuerzos: un docente prepara la unidad de Termodinámica, otro actualiza los ejercicios de Cinemática y un tercero pule las lecturas complementarias. Las mejoras de uno benefician al instante a los demás.
- #strong[El fin del material efímero y disperso:]~Actualmente, los añadidos del profesor acaban en fotocopias sueltas que los alumnos pierden o en carpetas olvidadas del ordenador de casa. Con este flujo, cualquier retoque que se haga tras una clase («este ejercicio ha resultado confuso, añado una aclaración») queda registrado en el repositorio y se hereda de forma natural al curso siguiente. El patrimonio didáctico del profesor no se reinicia cada septiembre; crece año a año.
- #strong[Autonomía pedagógica total:]~El temario se ajusta a la realidad del grupo. Si el curso avanza más lento, no hay que justificar ante las familias por qué se quedó medio libro sin abrir; si hay un acontecimiento histórico o científico de actualidad, se redacta una ficha de dos párrafos en Markdown, se compila y esa misma tarde está disponible en la web y lista para reprografía.

#strong[¿Qué programas concretos pueden instalar los profesores en sus ordenadores Windows para trabajar día a día?]

No hace falta abandonar el entorno habitual de ventanas ni aprender programas oscuros. Conviene, eso sí, explicar de entrada con qué criterio se eligen, porque algunos de los que siguen no son software libre y podría parecer contradictorio recomendarlos en un documento como este.

El criterio es sencillo: #strong[lo que hay que proteger es el fichero, no el programa]. Las dos garantías de esta propuesta son que el material está en texto plano y que vive en un sistema de control de versiones. Mientras eso se cumpla, el editor con el que se escriba es una preferencia personal y perfectamente reemplazable: si mañana un programa cambia sus condiciones o deja de mantenerse, los apuntes siguen ahí, legibles con cualquier otro y con toda su historia intacta. Es justo lo contrario de lo que ocurre con un documento de Word alojado en una nube de pago, donde el programa y el fichero son inseparables y el segundo es rehén del primero. Por eso aquí se prefiere la herramienta que menos fricción cause al docente, indicando en cada caso si es libre o privativa para que cada centro decida con conocimiento de causa.

Una advertencia práctica que ahorra disgustos: conviene descartar de entrada las herramientas cuyo plan gratuito excluye los repositorios privados o autoalojados, porque acaban convirtiéndose en una cuota por usuario justo cuando el proyecto empieza a funcionar.

Con ese criterio, para Windows existen estas opciones:

- #strong[Para redactar (editores visuales sin fricción):]

  - #strong[MarkText:]~Gratuito y de código abierto. Funciona en modo~#emph[WYSIWYG]~(lo que ves es lo que obtienes): al escribir~`# Título`, el texto se transforma al instante en un encabezado maquetado sin dejar los símbolos a la vista. La sensación es idéntica a escribir en un procesador tradicional limpio y sin distracciones.
  - #strong[#link("https://obsidian.md")[Obsidian]:]~Gratuito para cualquier uso desde 2025, aunque de código cerrado. Ideal para estructurar cursos enteros como carpetas en Windows. Incluye árbol de archivos lateral, enlaces entre temas, corrector ortográfico en español y previsualización en vivo.
  - #strong[VSCodium/VS Code:]~VSCodium es la compilación libre del mismo programa. Para los departamentos de Ciencias resulta cómodo porque previsualiza las fórmulas mientras se escriben, y trae el control de versiones integrado, sin necesidad de un programa aparte. Es además el editor que conviene al docente dinamizador que mantenga la plantilla del departamento, ya que con la extensión Tinymist puede trabajar directamente sobre el fichero Typst. Para el resto del claustro no hace ninguna falta: se escribe en Markdown.

- #strong[Para controlar versiones de forma visual (fuera de VS Code):]

  Para ver qué se ha modificado sin abrir terminales ni editores técnicos, existen dos soluciones de escritorio idóneas:

  - #strong[GitHub Desktop:]~Privativo (es de Microsoft), pero gratuito, sin necesidad de permisos de administrador y compatible con cualquier servidor Gitea o Forgejo por HTTPS. Al abrirlo muestra la lista de archivos modificados; al pinchar en un tema, la pantalla se divide en dos y resalta en~#strong[rojo]~las frases borradas y en~#strong[verde]~los párrafos añadidos. Abajo a la izquierda se rellena el recuadro «¿Qué has cambiado?» y se pulsa~#emph[Confirmar y sincronizar]. Conviene saber que sirve para sincronizar, no para todo: las propuestas de cambio entre compañeros se hacen desde la interfaz web de Gitea, que es también donde se revisan y se aprueban.
  - #strong[#link("https://tortoisegit.org")[TortoiseGit]:]~Se integra directamente en el Explorador de Archivos de Windows. Las carpetas de las asignaturas muestran iconos sobre el icono del archivo: un tic verde si el tema está al día y un círculo rojo si se ha modificado. Basta con hacer clic derecho sobre la carpeta, pulsar~#emph[Comparar cambios]~para revisar las diferencias línea a línea, redactar el mensaje de confirmación y enviar. Un detalle que conviene consultar antes con el coordinador TIC: al integrarse en el Explorador, TortoiseGit exige permisos de administrador para instalarse, cosa que no siempre está al alcance del docente en un equipo gestionado por la consejería.

- #strong[Para la gestión bibliográfica y exportación:]

  - #strong[Zotero + Zotero Connector:] Gratuito, de código abierto y disponible en Windows. Se integra en el navegador web habitual (Chrome, Firefox, Edge). Cuando el profesor consulta un artículo, una página de divulgación o una ley, pulsa el botón del conector y Zotero extrae título, autores, fecha y enlace al instante. Con el complemento gratuito #emph[Better BibTeX], Zotero exporta y actualiza de forma transparente el archivo `referencias.bib` de la asignatura cada vez que se añade una fuente.
  - #strong[#link("https://www.jabref.org")[JabRef]:]~Software con instalador nativo para Windows. Permite introducir el ISBN de un libro para rellenar automáticamente todos sus datos y mantener el archivo~`referencias.bib`~al día sin editar código bibliográfico a mano. 
  
  #figure(image("./pics/Pasted image 20260906214906.png", alt: "JabRef"),
  caption: [
    Una bibliografía en Jabref
  ]
)

  - #strong[Ningún conversor en el equipo del profesor.]~Podría esperarse aquí la recomendación de algún programa para transformar los apuntes en PDF. No la hay, y es deliberado: como se explicó al hablar de la fricción, esa tarea corresponde al servidor del centro. El docente escribe y guarda; el cuadernillo maquetado aparece solo. Si en algún momento hiciera falta un~`.docx`~para un trámite administrativo, el propio repositorio puede generarlo igual, sin instalar nada.

#strong[¿Cuánto tiempo de adaptación requiere para el profesorado no técnico?]

El aprendizaje se divide en dos fases muy breves:

- #strong[Escribir en Markdown:] Se asimila en menos de 20 minutos. Consiste en aprender cuatro convenciones básicas para estructurar el contenido (una almohadilla `#` para títulos, asteriscos `**` para negritas o guiones, `-`, para listas). Un recurso al respecto es #link("https://www.markdowntutorial.com/")[Markdown Tutorial] y hay páginas web para practicar libremente como #link("https://stackedit.io")[StackEdit]
- #strong[Entregar o sincronizar:] Gracias a interfaces visuales y botones integrados en el editor o en el explorador de Windows, el docente solo debe aprender a pulsar un botón de «guardar cambios» y escribir una frase descriptiva. No requiere aprender informática ni comandos abstractos. El foco sigue estando íntegramente en la redacción de la materia.

#strong[¿Qué ocurre si el centro o el hogar se queda sin conexión a internet?]

El sistema sigue funcionando con total normalidad. A diferencia de suites ofimáticas en la nube (Google Docs o Microsoft 365, e.g.) que se bloquean o impiden el acceso sin conexión, el texto plano reside de forma nativa en el disco duro del ordenador. Los profesores pueden:

- Seguir leyendo, redactando y editando sus apuntes sin cobertura.
- Guardar el trabajo localmente.
- Sincronizar los cambios con la plataforma del centro en el momento en que vuelva la red, sin perder una sola línea de texto ni depender de un servidor externo activo.

#strong[¿Cómo gestiona este modelo la brecha digital y la falta de dispositivos en casa?]

El modelo reduce la brecha económica y técnica en lugar de ensancharla:

- #strong[Independencia del hardware:]~Los archivos de texto plano pesan kilobytes y no exigen ordenadores potentes ni tabletas modernas. Funcionan en equipos antiguos o reacondicionados que las plataformas comerciales dejan obsoletos.
- #strong[El papel como red de seguridad:]~Quien no disponga de ordenador en casa no queda excluido del aprendizaje. El alumno recibe el cuadernillo en papel impreso por la reprografía del colegio a bajo coste, disponiendo exactamente del mismo contenido que sus compañeros sin depender de pantallas obligatorias para estudiar.

= Anexo: la propuesta a escala autonómica
<anexo-autonomico>
Todo lo anterior funciona dentro de un solo instituto y no necesita permiso de nadie para empezar: basta con un departamento decidido. Este anexo se dirige a un lector distinto —quien administra el presupuesto y la normativa de una comunidad autónoma— y plantea qué ocurriría si la escala dejara de ser el centro y pasara a ser la red. Nada de lo dicho hasta aquí depende de que esta parte se acepte.

Si este modelo es viable dentro de un instituto, a escala autonómica cambia la naturaleza misma del gasto. Administraciones como la Comunidad de Madrid destinan cada año decenas de millones de euros al programa Accede @acuerdo_gobierno_accede, y ese dinero cumple su función: las familias no pagan los libros. Pero conviene reparar en qué compra exactamente. Compra licencias temporales y manuales cerrados; es decir, alquila. Al cabo de una década de transferencias continuadas a las editoriales, la administración no es titular de una sola línea de texto y tiene que volver a empezar. La pregunta que abre este anexo no es si el gasto está justificado —lo está—, sino por qué no compra además un activo duradero.

¿Qué sucedería si la administración autonómica asumiera la titularidad del código fuente de sus propios materiales educativos?

== El repositorio central y la autonomía de centro (El #emph[fork] docente)
<el-repositorio-central-y-la-autonomía-de-centro-el-fork-docente>
A nivel autonómico, el objetivo no es imponer un manual único y doctrinario desde un despacho central, sino articular #strong[un punto de partida público, modular y vivo]:

+ #strong[La base institucional:] La Consejería de Educación mantiene el repositorio oficial de cada materia y nivel (por ejemplo, `madrid/lengua-4eso`), redactado y revisado por comisiones docentes con estricto apego al currículo.
+ #strong[Autonomía y libertad de cátedra:] Ningún instituto está forzado a consumir el bloque cerrado. Cada departamento puede realizar una derivación (#emph[fork]) del repositorio oficial hacia su propia instancia escolar y adaptarlo a su contexto: alterar el orden temático, profundizar en autores locales o añadir ejercicios de refuerzo.
+ #strong[El aula que nutre al sistema:] La colaboración fluye en ambos sentidos. Si un profesor de un centro periférico diseña una explicación sobresaliente o detecta una errata en el temario general, puede proponer una aportación (#emph[Pull Request]) al repositorio oficial de la Comunidad. Por primera vez, el talento de un docente particular revierte de forma directa en toda la red educativa regional.

Reorientar las partidas millonarias del modelo editorial hacia la infraestructura abierta no solo alivia el bolsillo de las familias; capitaliza las inversiones ya realizadas por la administración y devuelve el control pedagógico a los claustros.

== Una sola instancia bien cuidada
<instancia-unica>
Si algo enseñan los precedentes reunidos en este documento, es que estos proyectos no se apagan por falta de software, sino por falta de alguien que los sostenga. The Programming Historian funciona porque hay una responsable de publicación con nombre, cargo y retribución. FHSST se quedó por el camino porque la carga técnica recaía sobre un puñado de voluntarios que acabaron desbordados. Es la variable decisiva, y no es un detalle de implantación: es la implantación.

De ahí la recomendación más importante de este anexo, que además es la más barata. #strong[Que la consejería aloje una sola instancia de Gitea o Forgejo para toda la red, en lugar de que cada centro monte la suya.] Un instituto no necesita un servidor: necesita un repositorio. Y la diferencia entre ambas cosas es la que separa que este modelo sea sostenible de que no lo sea.

Las razones son de puro sentido común administrativo:

+ #strong[Una máquina bien mantenida en lugar de doscientas a medias.] Las actualizaciones de seguridad, las copias de seguridad, la disponibilidad en época de exámenes y la configuración de la compilación automática se resuelven una vez, por personal cuyo oficio es ése, y no doscientas veces por coordinadores TIC con tres horas de reducción.
+ #strong[El cumplimiento normativo se resuelve una vez.] El Esquema Nacional de Seguridad, el registro de tratamiento de datos y la figura del delegado de protección de datos son exigencias que una consejería ya tiene resueltas para sus sistemas corporativos, y que en cambio resultan gravosas para un centro aislado.
+ #strong[La colaboración entre centros deja de ser un problema técnico.] Si todos los institutos trabajan en la misma instancia, proponer una mejora al material de otro centro cuesta un clic. Con doscientas instancias separadas, cada intercambio exige configuración, permisos y buena voluntad. La bifurcación sin retorno que hoy padecen los libros de Marea Verde entre Madrid, Murcia y la Comunidad Valenciana es precisamente el resultado de trabajar en compartimentos separados.
+ #strong[Y sale más barato.] Un servicio de este tipo consume una fracción ínfima de los recursos que la administración ya destina a sus plataformas educativas. Comparado con las decenas de millones anuales del programa de préstamo, el coste de alojarlo es ruido estadístico.

Nada de esto impide que un centro decidido empiece por su cuenta mañana mismo, como se explicó en su momento; de hecho es probable que así ocurra, y es la mejor manera de demostrar que la cosa funciona. Pero conviene ser claros sobre el orden: un instituto puede iniciar el camino en solitario, y una red educativa entera no debería recorrerlo así.

== La licencia: qué permiso se concede exactamente
<la-licencia>
Publicar «bajo Creative Commons» no dice nada por sí solo: existen seis licencias distintas y la elección tiene consecuencias prácticas inmediatas. Esta propuesta adopta #strong[CC BY-NC-SA 4.0] —Reconocimiento, No Comercial, Compartir Igual—, la misma que emplea Apuntes Marea Verde.

La razón decisiva es que ninguna otra licencia abierta protege lo que aquí se quiere proteger. Resulta tentador suponer que la cláusula de «compartir igual» (SA) basta por sí sola para impedir que una editorial se apropie del trabajo docente, pero no es así: bajo CC BY-SA cualquier empresa puede reimprimir un temario íntegro y venderlo al precio que decida, sin deber nada más que la mención de autoría, porque una reproducción literal no genera obra derivada y la cláusula SA nunca llega a activarse. Sólo la cláusula NC cierra esa puerta. Y si el material nace del trabajo de docentes pagados con fondos públicos, carece de sentido que una editorial pueda empaquetarlo y revendérselo después a las mismas familias.

Conviene precisar el encaje normativo sin exagerarlo. El Decreto 168/2018 @decreto_168_2018 exige, para que un material de elaboración propia entre en el Programa Accede, que sus autores «autoricen su explotación como recursos educativos abiertos, permitiendo la distribución de la obra y la creación de obras derivadas, con fines no comerciales, bajo licencia abierta». Eso es un mínimo de permisos que hay que conceder, no una licencia concreta impuesta —el propio texto habla de indicar «su tipo de licencia abierta», dando por supuesto que hay varias admisibles—. CC BY-NC-SA lo satisface de forma directa, pero la elección es deliberada y hay que defenderla como tal, no atribuirla a una obligación reglamentaria que no existe.

Conviene, no obstante, ser consciente de lo que esta elección cuesta, y anticiparlo por escrito antes de que lo pregunte alguien:

- #strong[La ambigüedad de «no comercial» hay que despejarla explícitamente.] La cláusula NC es célebre por su indefinición, y aquí roza un punto sensible: si el cuadernillo lo imprime una copistería privada cobrando al alumno, ¿constituye eso un uso comercial? Para que la duda no paralice justamente el mecanismo que se propone, cada repositorio debe incluir una autorización expresa de sus autores: se permite la reproducción a precio de coste por parte de centros educativos y de los servicios de reprografía que estos contraten.
- #strong[Con material ajeno bajo CC BY-SA se puede trabajar, pero sólo sin tocarlo.] Una imagen publicada bajo CC BY-SA —el inmenso fondo de Wikimedia Commons, por ejemplo— sí puede incluirse tal cual en un cuadernillo con licencia NC: se considera una colección, no una obra derivada, y la imagen conserva su propia licencia. Lo que no se puede es modificarla. Un simple recorte es discutible; traducir al castellano los rótulos de un esquema es, sin ninguna duda, crear una obra derivada, y toda obra derivada de un original BY-SA debe publicarse también como BY-SA, cosa incompatible con NC. La misma prohibición alcanza al texto ajeno bajo BY-SA: cabe citarlo delimitado, no fundirlo en la redacción propia. De ahí una regla práctica para los departamentos: #strong[dominio público o CC0 para todo lo que haya que editar o traducir; BY-SA sólo para lo que se use intacto.]
- #strong[Cada imagen ajena necesita su propio pie de licencia.] No es una formalidad burocrática: amparar una imagen BY-SA bajo un rótulo global de «esta obra está bajo CC BY-NC-SA» infringe la propia licencia BY-SA, que prohíbe expresamente imponer restricciones adicionales sobre lo que se distribuye. Cada elemento reutilizado debe indicar autor, procedencia y licencia con su enlace, y el conjunto llevar la nota «salvo indicación en contrario». Tampoco puede aplicarse ninguna protección técnica que impida extraer la imagen del PDF.
- #strong[Se renuncia a algo, y conviene decirlo en voz alta.] En sentido estricto, una obra con cláusula no comercial no cumple la definición canónica de obra cultural libre, y queda fuera del alcance de quienes publican bajo BY-SA: los REA del proyecto EDIA del CEDEC @cedec_edia no pueden incorporarse aquí, ni estos materiales allí. Es, reconozcámoslo, una calle de sentido único hacia fuera del procomún. A cambio se obtiene la única garantía que de verdad impide la reventa comercial, que es justamente el abuso que esta propuesta nace para evitar.
- #strong[Y la licencia no se cumple sola.] Marea Verde, que emplea precisamente esta licencia, denunciaba en junio de 2026 la venta no autorizada de sus apuntes en plataformas comerciales. Una licencia declara una voluntad y proporciona el fundamento jurídico para reclamar; no sustituye a la vigilancia ni al trabajo de reclamar cuando toca.

= Glosario
<glosario>

- #strong[BibTeX y JabRef:]~Sistemas estandarizados para ordenar fuentes bibliográficas. En lugar de copiar y pegar enlaces largos a mano, permiten organizar libros y artículos en una ficha ordenada y citarlos de forma académica uniforme.
- #strong[Bifurcación (#emph[Fork]):] Copia personalizada y vinculada de un repositorio central que permite a un centro adaptar los materiales autonómicos a su propio ritmo sin perder las actualizaciones del temario original.
- #strong[Confirmación (#emph[Commit]):] Es el acto de consolidar un avance. Equivale a hacer un «guardado oficial» acompañado de una breve nota explicativa (#emph[«Añadido el tema 4»] o #emph[«Corregidas las erratas del examen»]). Evita tener decenas de archivos con nombres como `Tema1_final_v2_este_sí.docx`.
- #strong[Control de versiones (Git):]~Un sistema que funciona como una «cámara de fotos temporal» para los documentos. Cada vez que alguien decide registrar un avance, el sistema guarda una copia exacta con una breve explicación. Permite revisar qué cambió, cuándo y volver atrás si hubo una equivocación.
- #strong[Gitea/Forgejo:]~Una plataforma web privada (similar a una nube escolar) donde se guardan esos historiales de documentos. Permite trabajar en equipo, revisar entregas y leer los materiales desde el navegador.
- #strong[LaTeX:] Estándar clásico de edición y maquetación utilizado en la universidad y en publicaciones científicas internacionales. Está especializado en componer fórmulas matemáticas, ecuaciones químicas y documentos técnicos complejos con precisión milimétrica, evitando que los símbolos se descoloquen o pierdan nitidez al imprimirse. En este modelo, herramientas modernas como Typst recogen su testigo con una sintaxis más rápida y sencilla, pero conservando su misma exactitud gráfica.
- #strong[Markdown:] Un método intuitivo de dar estructura al texto mientras se escribe. En lugar de buscar botones en barras de herramientas para poner negritas o títulos, se usan signos directos sobre el teclado (como `#` para un encabezado o `*` para una lista). Cualquier editor lo interpreta y lo muestra formateado de inmediato.
- #strong[Pandoc:]~Una herramienta conversora que actúa como un «traductor universal». Toma el texto plano redactado por el profesor y lo transforma, en cuestión de segundos, en un documento PDF listo para reprografía o en una página web.
- #strong[Propuesta de cambio (#emph[Pull Request] o #emph[Merge Request]):] La vía para colaborar sin pisarse el trabajo. Si un profesor mejora una unidad didáctica o detecta un fallo en los apuntes de otro compañero, no sobreescribe el texto directamente: le envía una sugerencia formal de cambios. El autor o el jefe de departamento puede revisar las diferencias en pantalla, comentarlas y aceptarlas con un solo clic.
- #strong[Repositorio (#emph[Repo]):] Es el equivalente a una «carpeta compartida inteligente» del departamento o de la asignatura. A diferencia de una carpeta corriente de Windows o de Drive, el repositorio guarda no solo los documentos actuales, sino también toda su historia: quién aportó cada párrafo, cuándo se corrigió y cómo era el texto el curso anterior.
- #strong[Texto plano (`.md`, Markdown):]~Archivos que contienen únicamente palabras y signos de puntuación estándar, sin códigos ocultos ni formatos invisibles. Se pueden abrir y leer en cualquier dispositivo, hoy o dentro de cincuenta años, sin depender de un programa de pago.
- #strong[Typst:] Una herramienta moderna de composición tipográfica que sustituye la maquetación manual. En esta propuesta el profesorado no la utiliza directamente: escribe en Markdown y es el servidor quien invoca a Typst para calcular saltos de página, márgenes y tipografías, de modo que el cuadernillo salga impecable de la impresora. Sólo quien mantiene la plantilla del departamento llega a ver una línea de Typst.
- #strong[Zotero:] Un organizador bibliográfico personal que funciona como una biblioteca de bolsillo. Permite guardar libros, páginas web o artículos académicos con un solo clic desde el navegador, ordenando autores, fechas y títulos para citarlos después en los apuntes sin tener que teclear fichas a mano.

#pagebreak()

#bibliography("universo_libros.bib", title: "Bibliografía", style: "chicago-author-date")
