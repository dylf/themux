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
# Args fg, bg, content
###
create_segment_left() {
  local pos="left"
  local fg="$1"
  local bg="$2"
  local content="$3"
  set -ag status-${pos} "#[fg=${bg},bg=${fg},bold] ${content} #[fg=${fg},bg=${bg},nobold,nounderscore,noitalics]${THEME_SEPERATOR_RIGHT}"
}

###
# Args fg, bg, content
###
create_segment_right() {
  local pos="right"
  local fg="$1"
  local bg="$2"
  local content="$3"
  set -ag status-right " #[fg=${bg},bg=${fg},nobold,nounderscore,noitalics]${THEME_SEPERATOR_LEFT}#[fg=${fg},bg=${bg}] ${content} #[fg=${bg}"
}

main() {
  # local THEME_BLACK="#0c0c0c"
  # local THEME_WHITE="#b6b8bb"
  # local THEME_BLUE="#78a9ff"
  # local THEME_GREEN="#25be6a"
  # local THEME_PURPLE="#be95ff"
  # local THEME_PINK="#ee5396"
  # local THEME_GREY="#7b7c7e"
  # ---
  local THEME_BLACK="black"
  local THEME_WHITE="white"
  local THEME_BLUE="blue"
  local THEME_GREEN="green"
  local THEME_PURPLE="magenta"
  local THEME_PINK="red"
  local THEME_GREY="grey"

  THEME_SEPERATOR_RIGHT=""
  THEME_DIVIDER_RIGHT=""
  THEME_SEPERATOR_LEFT=""
  THEME_DIVIDER_LEFT=""

  THEME_SEPERATOR_RIGHT=""
  THEME_DIVIDER_RIGHT=""
  THEME_SEPERATOR_LEFT=""
  THEME_DIVIDER_LEFT="│"

  set -g mode-style "fg=${THEME_BLACK},bg=${THEME_WHITE}"
  set -g message-style "fg=${THEME_GREEN},bg=${THEME_BLACK}"
  set -g message-command-style "fg=${THEME_BLACK},bg=${THEME_WHITE}"
  set -g pane-border-style "fg=${THEME_WHITE}"
  set -g pane-active-border-style "fg=${THEME_BLUE}"
  set -g status "on"
  set -g status-justify "left"
  set -g status-style "fg=${THEME_GREEN},bg=${THEME_BLACK}"
  set -g status-left-length "100"
  set -g status-right-length "100"
  set -g status-left-style NONE

  reset_status_left
  # Session Name
  create_segment_left ${THEME_PURPLE} ${THEME_BLACK} "#S"

  reset_status_right
  # Time
  create_segment_right ${THEME_BLACK} ${THEME_PINK} "%Y-%m-%d ${THEME_DIVIDER_LEFT} %I:%M %p"
  # Hostname
  create_segment_right ${THEME_PINK} ${THEME_BLACK} "#h"
  # Session list
  create_segment_right ${THEME_BLACK} ${THEME_PINK} "#(tms sessions)"

  setw -g window-status-activity-style "underscore,fg=${THEME_GREY},bg=${THEME_BLACK}"
  setw -g window-status-separator  ""
  setw -g window-status-style "NONE,fg=${THEME_GREY},bg=${THEME_BLACK}"
  setw -g window-status-format "#[fg=${THEME_BLACK},bg=${THEME_BLACK},nobold,nounderscore,noitalics]${THEME_SEPERATOR_RIGHT}#[default] #I ${THEME_DIVIDER_RIGHT} #W #F #[fg=${THEME_BLACK},bg=${THEME_BLACK},nobold,nounderscore,noitalics]${THEME_SEPERATOR_RIGHT}"
  setw -g window-status-current-format "#[fg=${THEME_BLACK},bg=${THEME_GREEN},nobold,nounderscore,noitalics]${THEME_SEPERATOR_RIGHT}#[fg=${THEME_BLACK},bg=${THEME_GREEN},bold] #I ${THEME_DIVIDER_RIGHT} #W #F #[fg=${THEME_GREEN},bg=${THEME_BLACK},nobold,nounderscore,noitalics]${THEME_SEPERATOR_RIGHT}"

}

main
