# Fish completion para mcparch (mcparch)

# Función para obtener los iconos de la carpeta del proyecto
function __mcparch_get_icons
    set script_path (command -v mcparch)
    if test -z "$script_path"
        set script_path (realpath (status --current-filename))
    end

    if test -n "$script_path"
        set icons_dir (dirname "$script_path")/icons
        if test -d "$icons_dir"
            find "$icons_dir" -maxdepth 1 -type f -printf "%f\n"
        end
    end
end

# Función para obtener las versiones instaladas
function __mcparch_get_versions
    set versions_db_dir "$HOME/.config/mcparch/versions_db"
    if test -d "$versions_db_dir"
        ls "$versions_db_dir"
    end
end

# --- Opciones Principales ---
complete -c mcparch -n "__fish_use_subcommand" -s h -l help -d "Muestra el mensaje de ayuda"
complete -c mcparch -n "__fish_use_subcommand" -s i -l interactive -d "Abre el menú interactivo"
complete -c mcparch -n "__fish_use_subcommand" -s b -l build -d "Compila e instala los componentes"
complete -c mcparch -n "__fish_use_subcommand" -s a -l add -d "Añade una nueva versión desde un .apk" -r
complete -c mcparch -n "__fish_use_subcommand" -s r -l run -d "Ejecuta una versión específica" -r -a "(__mcparch_get_versions)"

# --- Gestión de Versiones ---
complete -c mcparch -n "__fish_use_subcommand" -s l -l list -d "Lista todas las versiones instaladas"
complete -c mcparch -n "__fish_use_subcommand" -s d -l remove -d "Elimina una versión específica" -r -a "(__mcparch_get_versions)"
complete -c mcparch -n "__fish_use_subcommand" -s sd -l set-default -d "Establece una versión como predeterminada" -r -a "(__mcparch_get_versions)"
complete -c mcparch -n "__fish_use_subcommand" -s ri -l rename -d "Renombra el ID de una versión" -r -a "(__mcparch_get_versions)"
complete -c mcparch -n "__fish_use_subcommand" -s cs -l shortcut -d "Crea un acceso directo de escritorio" -r -a "(__mcparch_get_versions)"
complete -c mcparch -n "__fish_use_subcommand" -s ad -l add-gui -d "Añade una versión usando un selector de archivos gráfico"

# --- Binarios Precompilados ---
complete -c mcparch -n "__fish_use_subcommand" -s gb -l get-binary -d "Descarga e instala un binario precompilado"
complete -c mcparch -n "__fish_use_subcommand" -s ip -l import -d "Instala binarios desde un .tar.gz" -r
complete -c mcparch -n "__fish_use_subcommand" -s ep -l export -d "Empaqueta los binarios locales en un .tar.gz" -r

# --- Gestión de Repositorios ---
complete -c mcparch -n "__fish_use_subcommand" -s ar -l add-repo -d "Añade un nuevo repositorio de binarios" -r
complete -c mcparch -n "__fish_use_subcommand" -s rr -l remove-repo -d "Elimina un repositorio por su nombre" -r
complete -c mcparch -n "__fish_use_subcommand" -s lr -l list-repos -d "Lista y comprueba los repositorios"
complete -c mcparch -n "__fish_use_subcommand" -s sr -l sync-repos -d "Sincroniza y repara los repositorios"

# --- Instalación y Mantenimiento ---
complete -c mcparch -n "__fish_use_subcommand" -s in -l install -d "Instala el script a nivel de sistema"
complete -c mcparch -n "__fish_use_subcommand" -s u -l uninstall -d "Desinstalación COMPLETA"
complete -c mcparch -n "__fish_use_subcommand" -s us -l uninstall-script -d "Desinstala SOLO el script del sistema"
complete -c mcparch -n "__fish_use_subcommand" -s up -l update -d "Busca y aplica actualizaciones para el script"
complete -c mcparch -n "__fish_use_subcommand" -s c -l check -d "Verifica la instalación y dependencias"
complete -c mcparch -n "__fish_use_subcommand" -s id -l install-deps -d "Instala las dependencias de compilación"
complete -c mcparch -n "__fish_use_subcommand" -s ic -l install-completion -d "Instala el autocompletado para tu shell"
complete -c mcparch -n "__fish_use_subcommand" -s sp -l setup-path -d "Añade el directorio de instalación al PATH"
complete -c mcparch -n "__fish_use_subcommand" -s cl -l cleanup -d "Limpia los directorios de código fuente"

# --- Opciones secundarias ---
complete -c mcparch -n "__fish_seen_subcommand_from -cs shortcut" -s ic -l icon -d "Usa un icono personalizado para el acceso directo" -r -a "(__mcparch_get_icons)"
