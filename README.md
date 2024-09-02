# Mantiz

A new Flutter project.

## Manejo de ramas
### Ramas principales
- main: Versión estable y libre de errores, funcionando en producción.
- develop: Versión para tabajar nuevas caracteristicas.
### Ramas de apoyo
- feature: Extiende de la rama __develop__ y contiene nuevas funcionalidades o mejoras, siempre se integra a __develop__
- release: Extiende de la rama __develop__ y se usara para pruebas finales y corregir errores menores, se integra a __develop__
- hotfix: Extiende de la rama __develop__ y se usara para corregir errores criticos que se presentaron en producción, se integra a __develop__
## Manejo de commits
### Palabras clave
- feat: Nueva caracteristica para el usuario
- fix: Correccion de errores
- docs: Cambios relacionados con la documentacion
- style: Cambios que no afectan la logica del codigo y solo lo visual
- refactor: Refactorizacion de codigo sin cambios en la funcionalidad
- test: Añadir o corregir pruebas
- perf: Cambios que mejoran el rendimiento de la app
## SecureStorage
### Keys
- fkPartner
- fkPartnerLicence
  



