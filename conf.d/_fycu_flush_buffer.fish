function _fycu_flush_buffer --on-event fish_prompt
    # Check if the global __BUFFER variable is not empty
    if test -n "$__BUFFER"
        # Just print what's there
        printf "$__BUFFER"
    end

    # And then clear it
    set __BUFFER ""
end
