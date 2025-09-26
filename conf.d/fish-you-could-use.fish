# Should only run if we're in an interactive shell
not status is-interactive; and exit

# These functions here just exist to forcibly load up the functions they're
# named after
function fycu_init_variables -d "Accessible version of _fycu_init_variables "
    _fycu_init_variables
end

function fycu_abbr_bind_space -d "Accessible version of _fycu_abbr_bind_space"
    _fycu_abbr_bind_space
end

function fycu_abbr_bind_newline -d "Accessible version of _fycu_abbr_bind_newline"
    _fycu_abbr_bind_newline
end

# Setup custom bindings needed to track abbr expansions
for mode in default insert
    bind -M $mode space fycu_abbr_bind_space
    bind -M $mode enter fycu_abbr_bind_newline
    bind -M $mode shift-enter fycu_abbr_bind_newline
end

# Initialize the helper variable
set --global __fycu_abbr_used 0

set --global FYCU_VERSION "1.0.0"
set --global FYCU_MESSAGE_POSITION before

# Turned off by default due to bugs with detection
set --global FYCU_ENABLE_ABBR false

# Verify filter variables
fycu_init_variables
