# Reporte de Debugging - Problemas con saveTicket() y savePhoto()

## Problemas Identificados

### 1. **Problema Principal en Http.dart (CRÍTICO)**
**Ubicación:** [lib/src/data/http/http.dart](lib/src/data/http/http.dart#L75-L89)

**Descripción:**
La clase `Http` estaba siendo demasiado restrictiva en su validación de respuestas exitosas (status 200). El código original hacía lo siguiente:

```dart
if (statusCode >= 200 && statusCode < 300) {
    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    if (json['response']['id'] > 0) {
      return Either.right(response.body);  // ✅ Éxito
    }
    return Either.left(HttpFailure(statusCode: statusCode));  // ❌ Error aunque sea 200!
}
```

**Por qué fallaba:**
- El servidor respondía con status **200** (éxito HTTP)
- Pero la respuesta no tenía la estructura `json['response']['id']` que el código esperaba
- O si la tenía, el `id` era <= 0
- Esto hacía que se devolviera un error aunque la respuesta fuera exitosa
- Además, si la respuesta no tenía esa estructura, causaba un `NoSuchMethodError`

**Solución Aplicada:**
```dart
if (statusCode >= 200 && statusCode < 300) {
  try {
    final json = Map<String, dynamic>.from(jsonDecode(response.body));
    // Solo validar si existe la estructura response.id y es inválido
    if (json.containsKey('response') && json['response'] is Map) {
      final responseObj = Map<String, dynamic>.from(json['response'] as Map);
      if (responseObj.containsKey('id') && responseObj['id'] is int && responseObj['id'] <= 0) {
        return Either.left(HttpFailure(statusCode: statusCode));
      }
    }
    // ✅ Si status es 2xx, considerar como éxito
    return Either.right(response.body);
  } catch (e) {
    // Si no puede parsear, pero status es 200, es éxito
    return Either.right(response.body);
  }
}
```

---

### 2. **Problema en savePhoto() - Estado Loading No Se Resetea**
**Ubicación:** [lib/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart](lib/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart#L130-L162)

**Descripción:**
En la rama de error del método `savePhoto()`, **no se estaba reseteando** `_isLoading = false`. Esto causaba que:
- Si la foto fallaba, el UI se quedaba esperando indefinidamente
- El usuario no podía interactuar con la app
- El indicador de loading permanecía activo

**Solución Aplicada:**
- Se agregó `_isLoading = false` en ambas ramas (éxito y error)
- Se envolvió el método en un `try-catch` para capturar excepciones inesperadas
- Se agregaron `print()` statements para debugging

---

### 3. **Problema en saveTicket() - Estado Loading No Se Resetea**
**Ubicación:** [lib/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart](lib/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart#L184-...)

**Descripción:**
Similar al problema anterior:
- `_isLoading` no se reseteaba en la rama de error
- Si el ticket fallaba, el UI se quedaba esperando
- Además, en el caso donde `title.isEmpty`, también faltaba resetear `_isLoading`

**Solución Aplicada:**
- Se agregó `_isLoading = false` en todas las ramas posibles
- Se agregó un `return` temprano cuando el título está vacío
- Se envolvió el método en un `try-catch`
- Se agregaron `print()` statements para debugging

---

## Cambios Realizados

### Archivo 1: `lib/src/data/http/http.dart`
- **Líneas 75-89:** Reescribir lógica de validación HTTP para ser más flexible
- Ahora acepta respuestas 2xx incluso si no tienen la estructura esperada
- Manejo seguro de excepciones durante parsing

### Archivo 2: `lib/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart`
- **Método savePhoto():** 
  - Agregar try-catch
  - Resetear `_isLoading` siempre al final
  - Agregar print statements para debugging
  
- **Método saveTicket():**
  - Agregar try-catch
  - Resetear `_isLoading` en todas las ramas
  - Agregar return temprano para title vacío
  - Agregar print statements para debugging

---

## Cómo Debuguear

Ahora que se han añadido los `print()` statements, verás en la consola logs como estos:

```
DEBUG savePhoto: Starting photo save with name=.jpg, type=image/jpeg
DEBUG savePhoto: Success received with uuid=xxxx-xxxx-xxxx
```

O en caso de error:

```
DEBUG savePhoto: Failure received: GeneralFailure.clientError
```

Esto te permitirá ver exactamente dónde está fallando el proceso.

---

## Próximos Pasos Recomendados

1. **Prueba la aplicación:**
   - Intenta guardar una foto
   - Intenta guardar un ticket
   - Observa los logs en la consola

2. **Verifica la respuesta del servidor:**
   - Asegúrate de que el servidor responda con status 200
   - Verifica la estructura JSON que devuelve
   - Añade logs adicionales si necesitas más información

3. **Considera normalizar las respuestas:**
   - Sería bueno que todas las APIs devuelvan una estructura consistente
   - Por ejemplo: `{ "success": true, "data": {...} }` o `{ "response": { "id": 1 }, "list": [...] }`

4. **Si sigue fallando:**
   - Toma una captura de la consola con los logs DEBUG
   - Verifica qué exactamente responde el servidor (usa Postman/Insomnia)
   - Compara con las otras APIs que SÍ funcionan
