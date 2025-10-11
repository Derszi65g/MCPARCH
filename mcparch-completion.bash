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

    local versions_db_dir="$HOME/.config/mcparch/versions_db"

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

    # Sugerir las opciones disponibles si la palabra actual empieza con '-'
    if [[ "${cur_word}" == -* ]]; then
        COMPREPLY=( $(compgen -W "${all_opts}" -- "${cur_word}") )
        return 0
    fi
}

# Registrar la función de autocompletado para el script
# Esto funcionará si lo ejecutas como 'mcparch' o './mcparch'
complete -F _mcparch_completions mcparch
complete -F _mcparch_completions ./mcparch
