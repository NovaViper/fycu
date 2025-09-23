function __fycu_abbr_bind_space
    # Perform the space expansion
    commandline -i " "
    # If we HAVEN'T ran an expansion, now we do so, same like before
    if test $__fycu_abbr_used != 1
        if abbr -q -- (string trim -- (commandline))
            set -g __fycu_abbr_used 1
        else
            set -g __fycu_abbr_used 0
        end
    end
    commandline -f expand-abbr
end
