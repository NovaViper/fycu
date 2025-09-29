function _transient_execute_fycu -d "Overlay fycu abbr check into starhsip's transient prompts"
    # If we HAVEN'T ran one yet, now's the time we do so
    if test $__fycu_abbr_used != 1
        # If the command actually matches, then we shall expand it (let the
        # system know we are!)
        if abbr -q -- (string trim -- (commandline))
            set -g __fycu_abbr_used 1
        else
            # And if not, then let the system know we're not
            set -g __fycu_abbr_used 0
        end
    end

    # Call the original function
    transient_execute
end
