# themux
A configurable theme plugin for tmux

## Usage
### TPM
1. Install [TPM](https://github.com/tmux-plugins/tpm)
2. Add the themux plugin:
```bash
set -g plugin 'dylf/themux'
```

### Configuration

themux will look for a `theme.yml` in `${XDG_CONFIG_HOME}/themux/` if set or `${HOME}/.config/themux`

The default config looks like this:
```yml
color_black: "black"
color_white: "white"
color_blue: "blue"
color_green: "green"
color_purple: "magenta"
color_pink: "red"
color_grey: "grey"
segment_right: ""
divider_right: ""
segment_left: ""
divider_left: ""
```

This will use the colors defined by your terminal. The default segments and dividers require a powerline or nerdfont.

This supports any color format that can be read by tmux.