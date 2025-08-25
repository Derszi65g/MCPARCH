#!/bin/bash

# Bash completion para mcparch (mcparch)

_mcparch_completions() {
    local cur_word prev_word
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    # Opciones que no esperan un ID de versión
    local opts_no_arg="-a --add -l --list -b --build --cleanup -u --uninstall --uninstall-system -i --interactive -h --help --install --install-deps --install-completion --update"
    # Opciones que SÍ esperan un ID de versión
    local opts_with_arg="-r --run --set-default --create-shortcut -d --remove-version"
    local all_opts="$opts_no_arg $opts_with_arg"

    local versions_db_dir="$HOME/.config/mcparch/versions_db"

    # Sugerir IDs de versión si el comando anterior lo requiere
    case "$prev_word" in
        -r|--run|--set-default|--create-shortcut|-d|--remove-version)
            if [ -d "$versions_db_dir" ]; then
                local versions
                versions=$(ls "$versions_db_dir")
                COMPREPLY=( $(compgen -W "${versions}" -- "${cur_word}") )
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
