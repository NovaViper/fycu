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
    _fycu_verify_ignored \
    _omp_enter_key_handler_fycu \
    _transient_execute_fycu

# Setup custom bindings needed to track abbr expansions
function _fycu_keybindings -d "Load default keybindings for FYCU"
    for mode in default insert
        bind -M $mode space _fycu_abbr_bind_space
        bind -M $mode shift-enter _fycu_abbr_bind_newline
        bind -M $mode enter _fycu_abbr_bind_newline
    end
end

function _fycu_keybindings_transient_prompts -d "Load oh-my-posh compatiable enter key binding" --on-event fish_prompt
    for mode in default insert
        # If any custom prompt is installed then add custom overlay that appends
        # the fycu logic to the respective original function
        if bind enter --user 2>/dev/null | string match -qe _omp_enter_key_handler # oh-my-posh
            bind -M $mode enter _omp_enter_key_handler_fycu
        else if bind enter --user 2>/dev/null | string match -qe transient_execute # starship
            bind -M $mode enter _transient_execute_fycu
        end
    end

    # Delete the function after it's ran as it's no longer needed afterward
    functions --erase _fycu_keybindings_transient_prompts
end

# Run the default keybindings
_fycu_keybindings
