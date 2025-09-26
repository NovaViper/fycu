function _fycu_check_aliases --on-event fish_preexec
    # Skip sudo commands
    string match --quiet -- "sudo *" "$argv"; and return
    # Start off being false, will be used to indicate if we found a match
    set --local found false
    # Convert the ignored aliases list into a regex compatible set of
    # strings
    set --local ignore_regex (string replace --all ',' '|' $FYCU_IGNORED_ALIASES)

    # Grab every alias and sort them, then store in the variable entry
    alias | sort | while read entry

        # Remove any whitespaces around the list
        set --local clean_entry (string trim "$entry")

        # FIXME: Don't seem to need it because fish aliases don't have = in them anymore? for version 4.0.8+
        # Strip off the '=' that's in alias definition string
        # set clean_entry (string replace -- "=" "" "$clean_entry")

        # Split the entries into separate parts, the alias' name and value
        # Ex: alias ls eza becomes 'alias' 'ls' 'eza'
        set --local tokens (string split --max 2 -- " " "$clean_entry")
        # Grab the alias's name and save it
        set --local key "$tokens[2]"

        # CLEAN_UP: May not be actually needed, causes MORE regex errors
        # Escapes any special characters in the alias name
        #set --local escaped_key (string escape --style=regex -- "$key")

        # If the alias is in the list of ignored aliases, then skip and
        # move onto the next alias
        string match --quiet --regex -- "^($ignore_regex)\$" "$key"; and continue

        # Remove the quotes around the alias' value via regex
        set --local value (string replace --regex -- '(?:[\"|\']([^,]*)[\"|\'])' '$1' "$tokens[3]")
        # Escapes any special characters in the alias value
        set --local escaped_value (string escape --style=regex -- "$value")

        # Check if the alias' value appears as a standalone command (it's in the
        # beginning in the command the user is trying to run)
        if string match --quiet --regex -- "^$escaped_value\$" "$argv"
            _fycu_message alias "$value" "$key"
            set found true
        end
    end

    "$found"
    #TODO: Need to work on hardcore mode, though it may not happen
    # "$found"; and _fycu_check_hardcore
end
