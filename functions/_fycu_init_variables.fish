function _fycu_init_variables
    # Add in the variables we want to check for the proper "text1,text2" format
    set --local var_list FYCU_IGNORED_ALIASES FYCU_IGNORED_GIT_ALAISES FYCU_IGNORED_ABBRS

    # Iterate through the list of variables
    for var in $var_list
        # Skip unset variables, as they are optional
        if not set -q "$var"
            continue
        end

        # Retrieve the value of the current variable, x
        set --local value (eval echo \$$var)

        # Skip empty variables, as they are optional
        if test -z "$value"
            continue
        end

        # If the format is incorrect, then print error and clear the variable 
        if not string match --quiet --regex -- '^[^,]+,[^,]+$' $value
            printf "\
          $(set_color -o red)Improper format for $var! Clearing the bad $(set_color magenta)($value)$(set_color red) to avoid execution errors!
        Expected format: \"alias,alias2\"$(set_color normal)\n"
            set --erase $var
        end
    end
end
