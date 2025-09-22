# Should only run if we're in an interactive shell
if not status is-interactive
    exit
end

set --global FYCU_VERSION "1.0.0"
set --global FYCU_MESSAGE_POSITION before

# Turned off by default due to bugs with detection
set --global FYCU_ENABLE_ABBR false

# Verify out variables
__fycu_init_variables

# functions --query \
#     __fycu_check_aliases \
#     __fycu_check_git_aliases \
#     ___fycu_flush_buffer
