function __fycu_write_buffer --argument-names contents

    # Takes the given contents and puts it in the beginning of the global BUFFER
    set --global __BUFFER "$contents$__BUFFER\n"

    # Helper variable to determine when the buffer should be printed
    set --local position before

    # If FYCU_MESSAGE_POSITION is set, then use its value instead
    if set -q FYCU_MESSAGE_POSITION
        set position "$FYCU_MESSAGE_POSITION"
    end

    # If the position is before, then flush the buffer (print and then clear)
    if test "$position" = before
        __fycu_flush_buffer
    else if test "$position" != after # If it doesn't match either "before" or "after", then error and flush
        printf "\
$(set_color -o red)Unknown value for MESSAGE_POSITION $FYCU_MESSAGE_POSITION
Expected value 'before' or 'after'. Falling back to 'before'"
        __fycu_flush_buffer
    end
end
