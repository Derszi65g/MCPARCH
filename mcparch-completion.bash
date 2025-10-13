#!/bin/bash

# Bash completion para mcparch (mcparch)

_mcparch_completions() {
    local cur_word prev_word
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    # Opciones
    local all_opts="--install -in \
    --uninstall -u \
    --uninstall-script -us \
    --build -b \
    --cleanup -cl \
    --interactive -i \
    --install-deps -id \
    --install-completion -ic \
    --setup-path -sp \
    --update -up \
    --check -c \
    --help -h \
    --add -a \
    --add-gui -ad \
    --list -l \
    --remove -d \
    --rename -ri \
    --run -r \
    --set-default -sd \
    --shortcut -cs \
    --get-binary -gb \
    --add-repo -ar \
    --remove-repo -rr \
    --list-repos -lr \
    --sync-repos -sr \
    --export -ep \
    --import -ip \
    --icon -ic"
    
    local plugin_opts="--get --add --remove --list"
    local main_commands="p"

    local versions_db_dir="$HOME/.config/mcparch/versions_db"
    local plugins_conf_file="$HOME/.config/mcparch/plugins.conf"
    local repos_conf_file="$HOME/.config/mcparch/repositories.conf"

    # Manejo de subcomandos de plugins
    if [ "$prev_word" = "p" ]; then
        local installed_plugins=""
        if [ -f "$plugins_conf_file" ]; then
            installed_plugins=$(cut -d':' -f1 "$plugins_conf_file" | tr '\n' ' ')
        fi
        COMPREPLY=( $(compgen -W "${plugin_opts} ${installed_plugins}" -- "${cur_word}") )
        return 0
    fi

    # Autocompletado para argumentos de subcomandos de plugins
    if [[ ${COMP_CWORD} -gt 1 ]]; then
        local command_before_prev="${COMP_WORDS[COMP_CWORD-2]}"
        if [ "$command_before_prev" = "p" ]; then
            case "$prev_word" in
                --remove)
                    if [ -f "$plugins_conf_file" ]; then
                        local installed_plugins
                        installed_plugins=$(cut -d':' -f1 "$plugins_conf_file")
                        COMPREPLY=( $(compgen -W "${installed_plugins}" -- "${cur_word}") )
                    fi
                    return 0
                    ;;
                --add)
                    COMPREPLY=( $(compgen -f -- "${cur_word}") ) # Autocompletado de archivos
                    return 0
                    ;;
                --get)
                    if [ -f "$repos_conf_file" ]; then
                        local plugin_repos
                        plugin_repos=$(awk '/plugins/ {gsub(/"/, "", $1); print $1}' "$repos_conf_file")
                        COMPREPLY=( $(compgen -W "${plugin_repos}" -- "${cur_word}") )
                    fi
                    return 0
                    ;;
            esac
        fi
    fi

    # Sugerir IDs de versión si el comando anterior lo requiere
    case "$prev_word" in
        -d|--remove|-r|--run|-sd|--set-default|-cs|--shortcut|-ri|--rename)
            if [ -d "$versions_db_dir" ]; then
                local versions
                versions=$(ls "$versions_db_dir")
                COMPREPLY=( $(compgen -W "${versions}" -- "${cur_word}") )
            fi
            return 0
            ;;
        -ic|--icon)
            local script_path
            script_path=$(realpath "${COMP_WORDS[0]}" 2>/dev/null)
            local icons_dir
            if [ -n "$script_path" ]; then
                icons_dir=$(dirname "$script_path")/icons
            fi

            if [ -d "$icons_dir" ]; then
                local icon_files=$( (cd "$icons_dir" && compgen -f -- "${cur_word}") )
                COMPREPLY=( ${icon_files} )
            else
                # Si no hay carpeta de iconos, autocompletado de archivos normal
                COMPREPLY=( $(compgen -f -- "${cur_word}") )
            fi
            return 0
            ;;
    esac

    # Sugerir las opciones principales o el comando 'p'
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${all_opts} ${main_commands}" -- "${cur_word}") )
    else
        # Para otros argumentos, solo sugerir opciones si corresponde
        if [[ "${cur_word}" == -* ]]; then
            COMPREPLY=( $(compgen -W "${all_opts}" -- "${cur_word}") )
        fi
    fi
}

# Registrar la función de autocompletado para el script
# Esto funcionará si lo ejecutas como 'mcparch' o './mcparch'
complete -F _mcparch_completions mcparch
complete -F _mcparch_completions ./mcparch
