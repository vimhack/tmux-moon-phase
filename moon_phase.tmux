#!/usr/bin/env bash
#
# Based on https://github.com/chriszarate/tmux-moon-phase
#

moon_phase_icon_color_option="@moon_phase_icon_color"
moon_phase_text_color_option="@moon_phase_text_color"

moon_phase_icon_color_default="#f1fa8c"
moon_phase_text_color_default="#f1fa8c"

get_moon_phase() {
    local lp newmoon now phase phase_number

    lp=2551443
    now=$(date -u +"%s")
    newmoon=592500
    phase="(($now - $newmoon) % $lp)"
    phase_number=$((((phase / 86400) + 1) * 100000))

    if [ $phase_number -lt 184566 ]; then
        echo "🌑| |New Moon"
    elif [ $phase_number -lt 553699 ]; then
        echo "🌒| |Naxing Crescent"
    elif [ $phase_number -lt 922831 ]; then
        echo "🌓| |First Quarter"
    elif [ $phase_number -lt 1291963 ]; then
        echo "🌔| |Waxing Gibbous"
    elif [ $phase_number -lt 1661096 ]; then
        echo "🌕| |Full Moon"
    elif [ $phase_number -lt 2030228 ]; then
        echo "🌖| |Waning Gibbous"
    elif [ $phase_number -lt 2399361 ]; then
        echo "🌗| |Last Quarter"
    elif [ $phase_number -lt 2768493 ]; then
        echo "🌘| |Waning Crescent"
    else
        echo "🌑| |New Moon"
    fi
}

get_tmux_option() {
    local option_value default_value

    option_value=$(tmux show-option -gqv "$1")
    default_value=$2

    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

update_status() {
    local moon_data status_value icon_color

    icon_color=$(get_tmux_option "$moon_phase_icon_color_option" "$moon_phase_icon_color_default")
    text_color=$(get_tmux_option "$moon_phase_text_color_option" "$moon_phase_text_color_default")

    moon_data=(${moon_phase//|/ })
    status_value="$(get_tmux_option "$1")"
    status_value="${status_value/$moon_phase_emoji_placeholder/${moon_data[0]}}"
    status_value="${status_value/$moon_phase_icon_placeholder/#[fg=$icon_color]${moon_data[1]}}"
    status_value="${status_value/$moon_phase_text_placeholder/#[fg=$text_color]${moon_data[2]} ${moon_data[3]}}"

    tmux set-option -gq "$1" "$status_value"
}

moon_phase_emoji_placeholder="\#{moon_phase_emoji}"
moon_phase_icon_placeholder="\#{moon_phase_icon}"
moon_phase_text_placeholder="\#{moon_phase_text}"

moon_phase=$(get_moon_phase)
update_status "status-left"
update_status "status-right"
