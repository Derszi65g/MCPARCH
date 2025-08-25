# MCPARCH - Gestor y Lanzador Avanzado para Minecraft PE en Linux

`mcparch` es un script de Bash todo-en-uno diseñado para compilar, gestionar y ejecutar múltiples versiones de Minecraft: Bedrock Edition (PE) en Linux de forma sencilla y robusta.

## Características Principales

# Screenshots

## MENU GAME

![](/assets/MENU.png)

## SHORTCUT

![](/assets/SHORTCUT.png)

## TUI MODE

![](/assets/TUI.png)

-   **Compilación Automatizada:** Clona y compila `mcpelauncher-client` y `mcpelauncher-extract` desde el código fuente, resolviendo conflictos comunes de librerías (como `zlib` vs `zlib-ng`) de forma aislada y segura.
-   **Gestión de Múltiples Versiones:** Instala y gestiona diferentes versiones del juego a partir de archivos `.apk`. ¡Cambia de una versión a otra con un simple comando!
-   **Lanzador Inteligente:** Ejecuta tu versión favorita por defecto o te permite elegir cuál lanzar si tienes varias.
-   **Menú Interactivo (TUI):** Una interfaz de texto amigable para acceder a todas las funciones sin necesidad de memorizar los comandos.
-   **Integración con el Escritorio:** Crea accesos directos `.desktop` en el menú de aplicaciones, utilizando un icono personalizado de Minecraft que viene integrado en el script.
-   **Autocompletado de Shell:** Instalación automática de autocompletado para **Bash, Zsh y Fish**, tanto para uso local como a nivel de sistema.
-   **Desinstalación Flexible:** Permite desinstalar solo el script del sistema o realizar una limpieza completa que elimina todos los datos del juego y componentes.

## Requisitos Previos

Antes de compilar, asegúrate de tener instaladas las siguientes herramientas:
-   `git`
-   `cmake`
-   `make`
-   `clang`
-   `curl`

El script verificará si existen antes de iniciar la compilación.

## Instalación y Primeros Pasos (Recomendado)

Para la mejor experiencia, instala `mcparch` como un comando de sistema siguiendo estos pasos.

**1. Clonar el repositorio:**
Primero, clona este repositorio en tu máquina local.
```bash
git clone https://github.com/Derszi65g/MCPARCH.git
cd MCPARCH
```

**2. Dar permisos de ejecución al script:**
```bash
chmod +x mcparch
```

**3. Instalar a nivel de sistema:**
Este comando copiará el script a `/usr/local/bin` e instalará el autocompletado para todos los usuarios.
```bash
sudo ./mcparch --install
```
Después de ejecutarlo, **reinicia tu terminal**. Ahora podrás usar el comando `mcparch` desde cualquier directorio.

**4. Compilar los componentes del launcher:**
Este paso descarga el código fuente de `mcpelauncher` y compila todo lo necesario. Solo necesitas hacerlo una vez.
```bash
mcparch --build
```

**5. Añadir tu primera versión de Minecraft:**
Necesitarás un archivo `.apk` compatible con la arquitectura **x86_64**.
```bash
mcparch --add
```

El script te pedirá la ruta al archivo `.apk` y un ID único para identificar esta versión (ej: `1.20.81`).

## Uso del Script

Una vez instalado, puedes usar el comando `mcparch` con las siguientes opciones.

### Gestión de Versiones
-   **Añadir una nueva versión:**
    ```bash
    mcparch --add
    ```
-   **Listar versiones instaladas:**
    ```bash
    mcparch --list
    ```
-   **Eliminar una versión específica:**
    **¡ADVERTENCIA!** Esto borrará los datos de esa versión del juego.
    ```bash
    # Uso: mcparch --remove-version <ID_DE_VERSION>
    mcparch --remove-version 1.20.x.x
    ```
-   **Establecer una versión por defecto:**
    La versión por defecto se ejecutará cuando lances el script sin argumentos.
    ```bash
    # Uso: mcparch --set-default <ID_DE_VERSION>
    mcparch --set-default 1.20.x.x
    ```

### Ejecutar el Juego
-   **Lanzar la versión por defecto (o elegir interactivamente):**
    ```bash
    mcparch
    ```
-   **Ejecutar una versión específica por su ID:**
    ```bash
    # Uso: mcparch --run <ID_DE_VERSION>
    mcparch --run 1.20.81
    ```
-   **Usar el menú interactivo:**
    Una forma cómoda de acceder a todas las funciones.
    ```bash
    mcparch --interactive
    ```

### Instalación y Mantenimiento
-   **Instalar a nivel de sistema (si aún no lo has hecho):**
    ```bash
    # Ejecutar desde el directorio del proyecto clonado
    sudo ./mcparch --install
    ```
-   **Desinstalar solo el script del sistema:**
    No elimina los datos del juego, solo el comando `mcparch` y el autocompletado.
    ```bash
    mcparch --uninstall-system
    ```
-   **Desinstalar TODO (sistema y datos de usuario):**
    **¡ADVERTENCIA!** Esto elimina el comando, los componentes compilados y **todos los datos del juego** (mundos, configuraciones, etc.).
    ```bash
    mcparch --uninstall
    ```
-   **Crear un acceso directo en el escritorio:**
    ```bash
    # Uso: mcparch --create-shortcut <ID_DE_VERSION>
    mcparch --create-shortcut 1.20.x.x
    ```
-   **Actualizar el script a la última versión:**
    ```bash
    mcparch --update
    ```
-   **Compilar o actualizar los componentes:**
    ```bash
    mcparch --build
    ```
-   **Instalar dependencias de compilación (opcional):**
    Si faltan `git`, `cmake`, etc., este comando intentará instalarlos usando el gestor de paquetes del sistema.
    ```bash
    mcparch --install-deps
    ```
-   **Limpiar los archivos de compilación:**
    ```bash
    mcparch --cleanup
    ```
-   **Mostrar la ayuda:**
    ```bash
    mcparch --help
    ```
-   **Configurar el PATH (para Void Linux, etc.):**
    ```bash
    mcparch --setup-path
    ```

### Uso Local (Sin instalación)
Si prefieres no instalar `mcparch` a nivel de sistema, puedes ejecutar todas las acciones con `./mcparch` desde el directorio clonado.

Para activar el autocompletado en este modo, ejecuta:
```bash
./mcparch --install-completion
```
Luego, reinicia tu terminal o ejecuta `source ~/.bashrc` (o el archivo de configuración correspondiente a tu shell).


## Mensaje para Usuarios
Este proyecto no apoya ni promueve la piratería de software. El uso de mcparch debe realizarse respetando las licencias y los términos de servicio de Minecraft: Bedrock Edition y sus desarrolladores. Este script está diseñado para facilitar la gestión y ejecución de versiones legítimas del juego en sistemas Linux usando archivos .apk obtenidos legalmente. El usuario es responsable de cumplir con las leyes aplicables al usar este software.
