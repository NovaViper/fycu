# TODO NEeds more testing
function __fycu_check_git_aliases --on-event fish_preexec
    # Skip sudo commands
    string match --quiet -- "sudo *" "$argv"; and return

    # If the entered command starts off with `git`
    if string match --quiet --regex -- "git *" "$argv"
        # Start off being false, will be used to indicate if we found a match
        set --local found false

        # Grab every git alias and sort them, then store them in the values key
        # and value
        git config --get-regexp "^alias\..+\$" | sort | while read key value
            # Separate "alias.*" from the alias names and sets key to just be
            # the alias name
            set key (string split --max 2 -- "." "$key")[2]

            # Escapes any special characters in the alias name
            set --local escaped_key (string escape --style=regex -- "$key")

            # If the alias is in the list of ignored git aliases, then skip and
            # move onto the next alias
            string match --quiet --regex -- "$escaped_key" "$FYCU_IGNORED_GIT_ALIASES"; and continue

            # Escapes any special characters in the alias value (the real
            # command it covers)
            set --local escaped_value (string escape --style=regex -- "$value")

            if string match --quiet --regex -- "git $escaped_value(?=\s|\$)" "$argv"
                __fycu_message "git alias" "$value" "git $key"
                set found true
            end

        end

        "$found"
        #TODO: Need to work on hardcore mode, though it may not happen
        # "$found"; and __fycu_check_hardcore
    end
end
