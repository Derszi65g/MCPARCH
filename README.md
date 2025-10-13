<div align="center">
  <a href="https://discord.gg/mwqYppvnVw"><img src="https://img.shields.io/badge/Comunidad_de_Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Comunidad de Discord" /></a>
</div>

# MCPARCH - Gestor y Lanzador Avanzado para Minecraft PE en Linux

`mcparch` es un script de Bash todo-en-uno diseñado para compilar, gestionar y ejecutar múltiples versiones de Minecraft: Bedrock Edition (PE) en Linux de forma sencilla y robusta.

## Características Principales

-   **Compilación Automatizada:** Clona y compila `mcpelauncher-client` y `mcpelauncher-extract` desde el código fuente, resolviendo conflictos comunes de librerías (como `zlib` vs `zlib-ng`) de forma aislada y segura.
-   **No Más Compilación (Opcional):** Importa y exporta binarios precompilados, o descárgalos desde repositorios de la comunidad. ¡Usa `mcpelauncher` sin compilar nada!
-   **Gestión de Múltiples Versiones:** Instala y gestiona diferentes versiones del juego a partir de archivos `.apk`. ¡Cambia de una versión a otra con un simple comando!
-   **Lanzador Inteligente:** Ejecuta tu versión favorita por defecto o te permite elegir cuál lanzar si tienes varias.
-   **Menú Interactivo (TUI):** Una interfaz de texto amigable para acceder a todas las funciones sin necesidad de memorizar los comandos.
-   **Integración con el Escritorio:** Crea y actualiza accesos directos `.desktop` en el menú de aplicaciones, permitiendo personalizar el icono.
-   **Autocompletado de Shell:** Instalación automática de autocompletado para **Bash, Fish y Zsh**, con todos los nuevos comandos y alias.
-   **Desinstalación Flexible:** Permite desinstalar solo el script o realizar una limpieza completa de todos los datos.

# Vistazo Rápido

## MENU GAME

![](/assets/MENU.png)

## SHORTCUT

| Icono default | Icono Personalizado |
| :--------------: | :--------------: |
| ![](/assets/SHORTCUT.png) | ![](/assets/SHORTCUT_2.png) |

## TUI MODE

![](/assets/TUI.png)


## Requisitos Previos

Antes de compilar, asegúrate de tener instaladas las siguientes herramientas:
-   `git`
-   `cmake`
-   `make`
-   `clang`
-   `curl`
-   `jq`

Puedes instalarlas manualmente o dejar que el script lo intente por ti con la opción `-id` o `--install-deps`.

## Instalación y Primeros Pasos

Para la mejor experiencia, instala `mcparch` como un comando de sistema.

**1. Clonar el repositorio:**
```bash
git clone https://github.com/Derszi65g/MCPARCH.git
cd MCPARCH
```

**2. Dar permisos de ejecución:**
```bash
chmod +x mcparch
```

**3. Instalar a nivel de sistema:**
Este comando copiará el script a `/usr/local/bin` e instalará el autocompletado.
```bash
# Usando el nuevo alias más corto
sudo ./mcparch -in
```
Después de ejecutarlo, **reinicia tu terminal**. Ahora podrás usar el comando `mcparch` desde cualquier directorio.

**4. Obtener los componentes del launcher:**
Tienes dos opciones: compilar desde el código fuente (requiere tiempo) o instalar binarios precompilados (rápido).

*   **Opción A: Compilar (El método tradicional)**
    ```bash
    # Usando el alias
    mcparch -b
    ```
*   **Opción B: Instalar sin compilar (Recomendado)**
    Primero, añade un repositorio de binarios. Por ejemplo, el de la comunidad:
    ```bash
    mcparch -ar https://raw.githubusercontent.com/Derszi65g/Mcparch-binarys/main/sources.json
    ```
    Luego, descarga e instala los binarios:
    ```bash
    mcparch -gb
    ```

**5. Añadir tu primera versión de Minecraft:**
Necesitarás un archivo `.apk` compatible con la arquitectura **x86_64**.
```bash
# Usando el alias
mcparch -a
```
El script te pedirá la ruta al archivo `.apk` y un ID único para identificar esta versión (ej: `1.21.0`).


## Guía de Uso Detallada

Esta sección explica en profundidad las funciones más importantes de `mcparch`.

### Jugar a Minecraft

-   **`mcparch`**
    -   Es el comando principal para jugar. Su comportamiento es inteligente:
    -   Si has establecido una versión por defecto con `-sd`, la lanzará directamente.
    -   Si no hay una versión por defecto pero solo tienes una instalada, la iniciará.
    -   Si tienes varias versiones y ninguna es la predeterminada, te mostrará un menú numerado para que elijas cuál ejecutar.
    -   Si no tienes ninguna versión instalada, te guiará para que añadas una.

-   **`mcparch -r <ID>` (o `--run <ID>`)**
    -   Lanza una versión específica de forma directa, sin menús, usando el ID que le asignaste al añadirla. Es ideal para scripts o para cuando sabes exactamente qué versión quieres.

-   **`mcparch -i` (o `--interactive`)**
    -   Inicia una interfaz de texto (TUI) que te guía a través de las operaciones más comunes como jugar, añadir/eliminar versiones, compilar, etc. Es la forma más fácil de usar el script si no recuerdas los comandos.

### Gestión de Versiones (con .apk)

-   **`mcparch -a [RUTA]` (o `--add [RUTA]`)**
    -   Registra una nueva versión del juego. Te pedirá un **ID único** (un "apodo" como `1.21.0` o `beta-texturas`) para que puedas identificarla fácilmente.
    -   También te pedirá la ruta al archivo `.apk` de Minecraft. **Importante:** Debe ser un `.apk` para la arquitectura **x86 o x86_64**, no los que se usan en teléfonos (ARM).
    -   Puedes pasar la ruta al `.apk` como argumento para saltarte la pregunta: `mcparch -a /ruta/a/mi/juego.apk`.

-   **`mcparch -ad` (o `--add-gui`)**
    -   Abre un selector de archivos gráfico (usando `zenity`) para que puedas elegir el `.apk` de forma visual, sin necesidad de escribir la ruta a mano.

-   **`mcparch -d <ID>` (o `--remove <ID>`)**
    -   **¡Comando destructivo!** Elimina permanentemente una versión, incluyendo su directorio de datos (mundos, texturas, configuraciones...). Siempre te pedirá una confirmación antes de borrar nada.

-   **`mcparch -sd <ID>` (o `--set-default <ID>`)**
    -   Establece una versión como la predeterminada. Esta es la que se lanzará cuando ejecutes `mcparch` sin argumentos.

-   **`mcparch -ri <ID_VIEJO> <ID_NUEVO>` (o `--rename <ID_VIEJO> <ID_NUEVO>`)**
    -   Permite cambiar el ID de una versión si te equivocaste o quieres organizarlas mejor.

-   **`mcparch -cs <ID>` (o `--shortcut <ID>`)**
    -   Crea un archivo `.desktop` en tu sistema, lo que hace que el juego aparezca en el menú de aplicaciones de tu entorno de escritorio (GNOME, KDE, etc.).
    -   **Icono personalizado:** Puedes añadir la opción `-ic <RUTA>` (o `--icon <RUTA>`) para usar un icono específico.
        -   Si pones una ruta completa (ej: `/home/user/icon.png`), usará ese archivo.
        -   Si solo pones un nombre de archivo (ej: `MCJA.svg`), lo buscará dentro de la carpeta `icons/` del proyecto `MCPARCH`.

### Instalación sin Compilar (Binarios)

Esta es la forma más rápida de tener `mcpelauncher` funcional, saltándote la compilación.

-   **`mcparch -ar <URL>` (o `--add-repo <URL>`)**
    -   Añade un "repositorio", que es simplemente una URL a un archivo `sources.json` en internet. Este archivo contiene una lista de binarios precompilados (el launcher y sus herramientas).
    -   **Necesitas añadir al menos un repositorio para poder descargar binarios.**
    -   *Ejemplo:* `mcparch -ar https://raw.githubusercontent.com/Derszi65g/Mcparch-binarys/main/sources.json`

-   **`mcparch -gb` (o `--get-binary`)**
    -   Consulta todos los repositorios que hayas añadido y te presenta una lista unificada de todos los binarios disponibles.
    -   Marcará como `(Recomendado)` aquellos binarios que sean compatibles con la arquitectura de tu sistema (ej: x86_64).
    -   Solo tienes que elegir un número de la lista para que se descargue e instale automáticamente.

-   **`mcparch -ip <RUTA>` (o `--import <RUTA>`)**
    -   Instala los binarios desde un archivo local `.tar.gz`. Es útil si has descargado los binarios manualmente o si un amigo te ha pasado su backup.

-   **`mcparch -ep <RUTA>` (o `--export <RUTA>`)**
    -   Si has compilado los componentes con `-b`, este comando los empaqueta en un único archivo `.tar.gz`. Este archivo es "portable" y puedes usarlo con `-ip` en otra máquina para no tener que volver a compilar.

### Gestión de Plugins

MCPARCH ahora cuenta con un sistema de plugins para extender su funcionalidad.

-   **`mcparch p --get [<REPO>]`**: Busca, instala o actualiza plugins desde repositorios.
-   **`mcparch p --add <RUTA.tar.gz>`**: Instala un nuevo plugin desde un paquete.
-   **`mcparch p --remove <COMANDO>`**: Desinstala un plugin por su comando.
-   **`mcparch p --list`**: Lista todos los plugins instalados.

### Mantenimiento del Script

-   **`mcparch -in` (o `--install`)**: Instala el script `mcparch` y el autocompletado en las carpetas del sistema para que puedas llamarlo desde cualquier terminal.
-   **`mcparch -up` (o `--update`)**: Comprueba si hay una nueva versión del script en GitHub. Si la hay, te mostrará los cambios y te preguntará si quieres actualizarte.
-   **`mcparch -us` (o `--uninstall-script`)**: Desinstala **únicamente** el script y el autocompletado. No toca los componentes compilados ni tus versiones del juego. Es útil si quieres dejar de usarlo como comando de sistema pero no quieres perder tus datos.
-   **`mcparch -u` (o `--uninstall`)**: **Desinstalación total.** Este comando ejecuta `-us` y además elimina los componentes compilados (`mcpelauncher-client`, etc.), los directorios de código fuente y te da la opción de borrar también todas tus versiones de Minecraft instaladas.
-   **`mcparch -c` (o `--check`)**: Realiza un diagnóstico completo para asegurar que todo funcione. Verifica:
    -   **Dependencias:** Si te falta `git`, `cmake`, `jq`, etc.
    -   **Componentes:** Si `mcpelauncher-client` está instalado.
    -   **Configuración:** Si los archivos en `~/.config/mcparch` son correctos.


## Resumen de Comandos (`mcparch -h`)

```
Uso: mcparch [opción] [argumento]

Gestor y Lanzador avanzado para Minecraft: Bedrock Edition en Linux.

Opciones Principales:
  -h, --help                   Muestra este mensaje de ayuda.
  -i, --interactive            Abre el menú interactivo para una gestión sencilla.
  -b, --build                  Compila e instala mcpelauncher desde el código fuente.
  -a, --add [RUTA]             Añade una nueva versión del juego desde un archivo .apk.
  -r, --run <ID>               Ejecuta una versión específica del juego por su ID.

Gestión de Versiones:
  -l, --list                   Lista todas las versiones de Minecraft instaladas.
  -d, --remove <ID>            Elimina una versión específica por su ID.
  -sd, --set-default <ID>      Establece una versión como predeterminada.
  -ri, --rename <ID_A> <ID_N>  Renombra el ID de una versión (Antiguo -> Nuevo).
  -cs, --shortcut <ID> [-ic, --icon <R>]  Crea o actualiza un acceso directo.
  -ad, --add-gui               Añade una versión usando un selector de archivos gráfico.

Gestión de Plugins:
  p --get [<REPO>]             Busca, instala o actualiza plugins desde repositorios.
  p --add <RUTA.tar.gz>        Instala un nuevo plugin desde un paquete.
  p --remove <COMANDO>         Desinstala un plugin por su comando.
  p --list                     Lista todos los plugins instalados.

Binarios Precompilados:
  -gb, --get-binary [<REPO>]   Descarga e instala un binario desde un repositorio.
  -ip, --import <RUTA>         Instala binarios desde un archivo .tar.gz local.
  -ep, --export <RUTA>         Empaqueta los binarios locales en un archivo .tar.gz.

Gestión de Repositorios:
  -ar, --add-repo <URL>        Añade un nuevo repositorio de binarios.
  -rr, --remove-repo <NOMBRE>  Elimina un repositorio por su nombre.
  -lr, --list-repos            Lista y comprueba los repositorios configurados.
  -sr, --sync-repos            Sincroniza y repara los nombres de los repositorios.

Instalación y Mantenimiento:
  -in, --install               Instala el script y el autocompletado a nivel de sistema.
  -u, --uninstall              Desinstalación COMPLETA (script, componentes, datos).
  -us, --uninstall-script      Desinstala SOLO el script y el autocompletado.
  -up, --update                Busca y aplica actualizaciones para este script.
  -c, --check                  Verifica la instalación, dependencias y configuración.
  -id, --install-deps          Intenta instalar las dependencias de compilación.
  -ic, --install-completion    Instala autocompletado para el shell actual (uso local).
  -sp, --setup-path            Añade automáticamente el directorio de instalación al PATH.
  -cl, --cleanup               Limpia los directorios de código fuente.

Comportamiento por defecto:
  Si no se proporciona ninguna opción, el script intentará ejecutar la versión por defecto o
  iniciará el juego de forma interactiva si hay varias versiones.
```

## Inspiración y Créditos
`mcparch` se inspira en gran medida en el proyecto `CC-MC` de Crow_Rei34, el cual sirvió como una excelente base y fuente de aprendizaje para este gestor y lanzador. Puedes encontrar el proyecto original aquí: [CC-MC by Crow_Rei34](https://codeberg.org/Crow_Rei34/CC-MC/)

## Mensaje para Usuarios
Este proyecto no apoya ni promueve la piratería de software. El uso de mcparch debe realizarse respetando las licencias y los términos de servicio de Minecraft: Bedrock Edition y sus desarrolladores. Este script está diseñado para facilitar la gestión y ejecución de versiones legítimas del juego en sistemas Linux usando archivos .apk obtenidos legalmente. El usuario es responsable de cumplir con las leyes aplicables al usar este software.
