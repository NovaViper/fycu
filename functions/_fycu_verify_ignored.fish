function _fycu_verify_ignored --argument-names ignore_var
    # Skip unset variables, as they are optional
    not set -q "$ignore_var"; and return

    # Retrieve the value of the current variable, x
    set --local value (eval echo \$$ignore_var)

    # Skip empty variables, as they are optional
    test -z "$value"; and return

    # If the format is incorrect, then print error and clear the variable 
    if not string match --quiet --regex -- '^[^,]+,[^,]+$' $value
        printf "\
$(set_color -o red)Improper format for $(set_color magenta)$ignore_var$(set_color red)! Clearing the bad value $(set_color magenta)($value)$(set_color red) to avoid execution errors!
Expected format: \"alias,alias2\"$(set_color normal)\n"
        set --erase $ignore_var
    end
end
