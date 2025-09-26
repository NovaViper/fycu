function _fycu_message --argument-names alias_type command alias
    # zero-width space delineates the end of a variable and the beginning of the
    # message
    _fycu_write_buffer "\
$(set_color -o yellow)Found existing $alias_type for $(set_color magenta)\"$command\"$(set_color yellow). You could use: $(set_color magenta)\"$alias\""
end
