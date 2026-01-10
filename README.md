🛠️ historydns

historydns es una herramienta CLI en Bash para consultar el **histórico DNS de un dominio**, pensada para soporte técnico, análisis de incidentes y validación de cambios DNS a lo largo del tiempo.

Permite identificar **qué registros DNS ha tenido un dominio**, cuándo aparecieron, cuándo cambiaron y compararlos contra el **DNS actual (live)**, sin depender de herramientas web externas.



🚀 ¿Qué hace?

historydns consulta información DNS usando múltiples fuentes para mostrar una visión completa del dominio:

- **SecurityTrails** (histórico DNS principal)
- **CIRCL Passive DNS** (histórico público complementario)
- **DNS live** (estado actual del dominio)

Con esto puede detectar:

- Registros **A / AAAA** (con PTR / reverse DNS)
- **MX**
- **TXT** (SPF, DKIM, DMARC, otros)
- **NS**
- **CNAME**
- **SOA**
- Cambios históricos (registros agregados y removidos)
- Diferencias entre histórico y DNS actual

Toda la información se muestra en un **formato tabular claro**, optimizado para terminal y lectura rápida.



📦 Requisitos

Funciona en **macOS y Linux**.

### Obligatorios
- `bash`
- `curl`
- `jq`

### Recomendados
- `dig`  
  (si no está disponible, se usa `host` como alternativa)

En macOS, `dig` suele venir instalado por defecto.



📥 Instalación (1 línea)

Ejecuta en la termminal:

curl -fsSL https://raw.githubusercontent.com/deivy-ramirez/historydns-cli/main/install.sh | bash

Esto hará automáticamente:

- Descargar el script historydns
- Dar permisos de ejecución
- Instalarlo en ~/.local/bin
- Asegurar que esté en el PATH

Si el comando no se reconoce de inmediato ejecutar:

source ~/.zshrc

o cierra y abre la terminal.


🔐 Fuentes de datos y credenciales (IMPORTANTE)

🟢 SecurityTrails (obligatorio)

Cada persona DEBE crear su propia cuenta en SecurityTrails y obtener su API Key.

No se comparten API Keys entre usuarios.

Pasos:

1. Crear cuenta en SecurityTrails
2. Obtener tu API Key
3. Editar el script historydns y pegar tu API Key

✏️ Configurar SecurityTrails API Key (desde Finder – macOS)

Una vez instalado el script:

1. Abre Finder
2. Dirigete a la ruta: user/bin/
3. Ubica el archivo: historydns
4. Clic derecho → Abrir con → Editor de texto
5. Busca la línea: SECURITYTRAILS_KEY="..."
6. Reemplaza con tu API Key: SECURITYTRAILS_KEY="TU_API_KEY_AQUI"
7. Guarda el archivo
8. ✅ Listo.


🟡 CIRCL Passive DNS

CIRCL requiere usuario y contraseña.

- Estas credenciales NO están en el repositorio
- Se solicitan por interno al administrador, puede ponerse en contacto a traves del correo devopsengineer@altforsteri.com
- No deben publicarse ni compartirse en GitHub

Una vez las tengas, configúralas según las indicaciones internas.


▶️ Uso básico

historydns dominio.com

Esto mostrará el histórico de los tipos más comunes:

- A
- MX
- TXT
- CNAME
- NS

▶️ Consultar un tipo específico

historydns dominio.com a
historydns dominio.com mx
historydns dominio.com txt
historydns dominio.com ns
historydns dominio.com cname

▶️ Comparar cambios históricos

historydns dominio.com a compare
historydns dominio.com mx compare

Muestra:

- Registros removidos
- Registros agregados
- Comparación entre el estado más antiguo y el más reciente

▶️ Listar con límite

historydns dominio.com a list 50

🧾 Ejemplo de análisis

historydns ejemplo.com a compare

Salida típica:

- DNS actual (live) con PTR
- Cambios históricos (Oldest → Newest)
- IPs removidas
- IPs agregadas
- Diferencias entre histórico y estado actual

⏱️ ¿Por qué puede tardar unos segundos?

Porque historydns:

- Consulta APIs externas
- Procesa histórico DNS
- Resuelve PTR para direcciones IP
- Normaliza datos de múltiples fuentes

Tiempo normal:

- 1–3 s → dominio simple
- 3–8 s → dominio con mucho histórico

🎯 Uso recomendado

- Diagnóstico de incidentes DNS
- Verificación de cambios antes y después de migraciones
- Soporte técnico de hosting y correo
- Confirmar si un dominio antes apuntaba a otro servidor
- Análisis cuando el cliente indica que “antes funcionaba”

🧑‍💻 Autor (Deivy R)

Herramienta desarrollada para uso técnico real
Optimizada para flujos de soporte, análisis DNS y troubleshooting profesional.
