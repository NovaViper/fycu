# Should only run if we're in an interactive shell
not status is-interactive; and exit

# Initialize the helper variable
set --global __fycu_abbr_used 0

set --global FYCU_VERSION "1.0.0"
set --global FYCU_MESSAGE_POSITION before

# Turned off by default due to bugs with detection
set --global FYCU_ENABLE_ABBR false

# Lock in event handlers for keybinds and initialization
functions -q \
    _fycu_abbr_bind_space \
    _fycu_abbr_bind_newline \
    _omp_enter_key_handler_fycu \
    _fycu_verify_ignored

# Setup custom bindings needed to track abbr expansions
function _fycu_keybindings -d "Load default keybindings for FYCU"
    for mode in default insert
        bind -M $mode space _fycu_abbr_bind_space
        bind -M $mode shift-enter _fycu_abbr_bind_newline
        bind -M $mode enter _fycu_abbr_bind_newline
    end
end

function _fycu_keybindings_omp -d "Load oh-my-posh compatiable enter key binding" --on-event fish_prompt
    # If oh-my-posh is installed then add custom overlay that appends the
    # fycu logic and then calls the original oh-my-posh function
    for mode in default insert
        if bind enter --user 2>/dev/null | string match -qe _omp_enter_key_handler
            bind -M $mode enter _omp_enter_key_handler_fycu
        end
    end

    # Delete the function after it's ran as it's no longer needed afterward
    functions --erase _fycu_keybindings_omp
end

# Run the default keybindings
_fycu_keybindings
