# Tmux Moon Phase

Display the current moon phase in tmux status bar.

## Installation

1. Install [Tmux Plugin Manager][tpm].

2. Add this plugin to your `~/.tmux.conf`:

```tmux
set -g @plugin 'vimhack/tmux-moon-phase#main'
```

3. Press [prefix] + `I` to install.

[tpm]: https://github.com/tmux-plugins/tpm

## Usage

Add `#{moon_phase_emoji}`/ `#{moon_phase_icon}` / `#{moon_phase_text}` to your `status-left` or `status-right`:

```tmux
set -g status-right '#{moon_phase_icon} #{moon_phase_text}'
```

Custom icon or text colors:

```tmux
set -g @moon_phase_icon_color '#f1fa8c'
set -g @moon_phase_text_color '#f1fa8c'
```

## Inspired By

<https://github.com/chriszarate/tmux-moon-phase>
