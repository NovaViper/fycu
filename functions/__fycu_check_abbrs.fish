function __fycu_check_abbrs --on-event fish_preexec
    # If the user DOES NOT to try the abbreviation check, then end the program,
    # otherwise continue
    test "$FYCU_ENABLE_ABBR" != true; and return

    # Skip sudo commands
    string match --quiet -- "sudo *" "$argv"; and return
    # Start off being false, will be used to indicate if we found a match
    set --local found false
    # Convert the ignored aliases list into a regex compatible set of
    # strings
    set --local ignore_regex (string replace --all ',' '|' $FYCU_IGNORED_ABBRS)

    # Grab every abbreviation
    abbr | sort | while read entry
        # Remove any whitespaces around the list
        set --local clean_entry (string trim "$entry")

        # Trim off `abbr -a -- --set-cursor*...` parts from the entries    
        set --local trim_entry (string replace --regex '.*-- ' '' -- "$clean_entry")

        # Split the entries into separate parts, the abbreviation name and its
        # real command
        set --local tokens (string split --max 1 -- " " "$trim_entry")

        # Grab the abbr's name and save it
        set --local key "$tokens[1]"

        # CLEAN_UP: May not be actually needed, causes MORE regex errors
        # Escape any special characters in the abbr name
        # set --local escaped_key (string escape --style=regex -- "$key")

        #TODO: Add ability to specify ignored abbreviations
        # If the alias is in the list of ignored abbrs, then skip and
        # move onto the next abbr
        string match --quiet --regex -- "^($ignore_regex)\$" "$key"; and continue

        # Remove the quotes around the abbr's value via regex
        # Escapes any special characters in the abbr value
        set --local value (string replace --regex -- '(?:[\"|\']([^,]*)[\"|\'])' '$1' "$tokens[2]")

        # For abbrs that let you move the cursor, we have to trim off the '%'
        # that's at the end
        set --local cursor_value (string replace --regex -- '%' '' "$value")

        # Escapes any special characters in the abbr value
        set --local escaped_value (string escape --style=regex -- "$value")

        # Check if the abbr's value appears as a standalone command (it's in the
        # beginning of the command the user is trying to run)
        if string match --quiet --regex -- "^$escaped_value\$" "$argv"
            __fycu_message abbr "$cursor_value" "$key"
            set found true
        end
    end

    "$found"
    #TODO: Need to work on hardcore mode, though it may not happen
    # "$found"; and __fycu_check_hardcore
end
