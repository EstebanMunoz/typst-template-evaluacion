#import "@local/fcfm-evaluacion:0.1.0": conf, subfigures, today

// Parámetros para la configuración del documento. Descomentar aquellas que se quieran usar
#let document-params = (
  "title": "Nombre evaluación",
  "subject": "Tema evaluación",
  "course-name": "Nombre Curso",
  "course-code": "AB1234",
  "teachers": (),
  "auxiliaries": (),
  "assistants": (),
  "due-date": today,
  "university": "Universidad de Chile",
  "faculty": "Facultad de Ciencias Físicas y Matemáticas",
  "department": "Departamento de Ingeniería Eléctrica",
  "logo": box(height: 1.57cm, image("assets/logos/die.svg")),
)

// Aplicación de la configuración del documento
#show: doc => conf(..document-params, doc)



////////// COMIENZO DEL DOCUMENTO //////////

