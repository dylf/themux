#!/usr/bin/env bash
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set() {
  tmux set "$@"
}

setw() {
  tmux setw "$@"
}

reset_status_left() {
  set -g status-left ""
}

reset_status_right() {
  set -g status-right ""
}

###
#  Read from the theme.yml file and set the variables
###
get_theme_values() {
  local theme_file="${XDG_CONFIG_HOME:-$HOME/.config}/themux/theme.yml"
  if [[ ! -f $theme_file ]]; then
    theme_file="${PLUGIN_DIR}/theme.yml"
  fi
  while IFS=':' read -r key value; do
    value="${value//\"/}" # Remove all occurrences of double quotes
    value="${value#"${value%%[![:space:]]*}"}" # Trim leading whitespace
    value="${value%"${value##*[![:space:]]}"}" # Trim trailing whitespace
    declare -g "$key=${value}"
  done < <(awk '/^[[:blank:]]*[a-zA-Z0-9_-]+: / {print $1,$2}' ${theme_file})

}

###
# Args fg, bg, content
###
create_segment_left() {
  local pos="left"
  local fg="$1"
  local bg="$2"
  local content="$3"
  set -ag status-${pos} "#[fg=${bg},bg=${fg},bold] ${content} #[fg=${fg},bg=${bg},nobold,nounderscore,noitalics]${segment_right}"
}

###
# Args fg, bg, content
###
create_segment_right() {
  local pos="right"
  local fg="$1"
  local bg="$2"
  local content="$3"
  set -ag status-right " #[fg=${bg},bg=${fg},nobold,nounderscore,noitalics]${segment_left}#[fg=${fg},bg=${bg}] ${content} #[fg=${bg}"
}

main() {
  get_theme_values

  set -g mode-style "fg=${color_black},bg=${color_white}"
  set -g message-style "fg=${color_green},bg=${color_black}"
  set -g message-command-style "fg=${color_black},bg=${color_white}"
  set -g pane-border-style "fg=${color_white}"
  set -g pane-active-border-style "fg=${color_blue}"
  set -g status "on"
  set -g status-justify "left"
  set -g status-style "fg=${color_green},bg=${color_black}"
  set -g status-left-length "100"
  set -g status-right-length "100"
  set -g status-left-style NONE

  reset_status_left
  # Session Name
  create_segment_left ${color_magenta} ${color_black} "#S"

  reset_status_right
  # Time
  create_segment_right ${color_black} ${color_red} "%Y-%m-%d ${divider_left} %I:%M %p"
  # Hostname
  create_segment_right ${color_red} ${color_black} "#h"
  # Session list
  create_segment_right ${color_black} ${color_red} "#(tms sessions)"

  setw -g window-status-activity-style "underscore,fg=${color_grey},bg=${color_black}"
  setw -g window-status-separator  ""
  setw -g window-status-style "NONE,fg=${color_grey},bg=${color_black}"
  setw -g window-status-format "#[fg=${color_black},bg=${color_black},nobold,nounderscore,noitalics]${segment_right}#[default] #I ${divider_right} #W #F #[fg=${color_black},bg=${color_black},nobold,nounderscore,noitalics]${segment_right}"
  setw -g window-status-current-format "#[fg=${color_black},bg=${color_green},nobold,nounderscore,noitalics]${segment_right}#[fg=${color_black},bg=${color_green},bold] #I ${divider_right} #W #F #[fg=${color_green},bg=${color_black},nobold,nounderscore,noitalics]${segment_right}"
}

main
