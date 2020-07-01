# ble.sh manual: https://github.com/akinomyoga/ble.sh/wiki


# immediately save history to $HISTFILE and share history between terminals
# https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A74-Editing#41213-bleopt-history_share-emptynon-empty-v04
bleopt history_share=1

# add short delay to auto-complete
bleopt complete_auto_delay=300

if command -v fzf &>/dev/null; then
    _ble_contrib_fzf_base=${XDG_DATA_HOME:-${HOME}/.local/share}/fzf/fzf
    ble-import -d contrib/fzf-completion
    ble-import -d contrib/fzf-key-bindings
fi

function my/keymap-settings-for-emacs-mode {
  # bind C-h to backwards delete word
  # https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A73-Key-Binding#33-keymap-keymap
  # https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A74-Editing#44-wordwise-movement-and-operation
  ble-bind -m emacs -f 'C-h' 'delete-backward-cword'
}

# create a function to be called through hook complete_load
# https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A77-Completion#7-completion
function my/complete-load-hook {
  # have auto-complete menu be only a single space between entries
  # https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A77-Completion#722-bleopt-complete_menu_style-v03
  bleopt complete_menu_style=dense-nowrap

  # ignore case for completion
  # https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A77-Completion#719-readline-variable-completion-ignore-case
  bind 'set completion-ignore-case on'

  # add siffixes to filename completions
  # https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A77-Completion#7111-readline-variable-visible-stats
  bind 'set visible-stats on'
}

# load hooks
blehook/eval-after-load keymap_emacs my/keymap-settings-for-emacs-mode
blehook/eval-after-load complete my/complete-load-hook
