# Fish completion para mcparch (mcparch)

# Opciones sin argumento
complete -c mcparch -n "__fish_use_subcommand" -l add -d "Añade una nueva versión de Minecraft"
complete -c mcparch -n "__fish_use_subcommand" -l list -d "Lista todas las versiones instaladas"
complete -c mcparch -n "__fish_use_subcommand" -l build -d "Compila e instala los componentes"
complete -c mcparch -n "__fish_use_subcommand" -l cleanup -d "Limpia los fuentes después de compilar"
complete -c mcparch -n "__fish_use_subcommand" -l uninstall -d "Desinstala los componentes"
complete -c mcparch -n "__fish_use_subcommand" -l uninstall-system -d "Desinstala solo el script del sistema"
complete -c mcparch -n "__fish_use_subcommand" -l interactive -d "Abre el menú interactivo"
complete -c mcparch -n "__fish_use_subcommand" -l help -d "Muestra el mensaje de ayuda"
complete -c mcparch -n "__fish_use_subcommand" -l install -d "Instala el script a nivel de sistema"
complete -c mcparch -n "__fish_use_subcommand" -l install-completion -d "Instala el autocompletado para tu shell"

# Función para obtener las versiones instaladas
function __mcparch_get_versions
    set versions_db_dir "$HOME/.config/mcparch/versions_db"
    if test -d "$versions_db_dir"
        ls "$versions_db_dir"
    end
end

# Opciones que requieren un ID de versión como argumento
complete -c mcparch -n "__fish_use_subcommand" -l run -d "Ejecuta una versión específica" -r -a "(__mcparch_get_versions)"
complete -c mcparch -n "__fish_use_subcommand" -l set-default -d "Establece una versión como predeterminada" -r -a "(__mcparch_get_versions)"
complete -c mcparch -n "__fish_use_subcommand" -l create-shortcut -d "Crea un acceso directo de escritorio" -r -a "(__mcparch_get_versions)"


# Abreviaciones (opcional, pero útil)
complete -c mcparch -n "__fish_use_subcommand" -s a -l add
complete -c mcparch -n "__fish_use_subcommand" -s l -l list
complete -c mcparch -n "__fish_use_subcommand" -s b -l build
complete -c mcparch -n "__fish_use_subcommand" -s u -l uninstall
complete -c mcparch -n "__fish_use_subcommand" -s i -l interactive
complete -c mcparch -n "__fish_use_subcommand" -s h -l help
complete -c mcparch -n "__fish_use_subcommand" -s r -l run