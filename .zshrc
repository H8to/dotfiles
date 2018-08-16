ENABLE_CORRECTION="false"

# Basic aliases
alias less='less -erX'
alias psg='ps uax|grep -i --color'
alias du="du -h"
alias cs="cd && clear"
alias vi="vim"
alias cam="guvcview"
alias screenoff="xset -display :0.0 dpms force off"
alias ll="exa -laghsname"
alias lsize="exa -laghssize"

# Trizen is an AUR manager with pacman wrapping functionality
alias pacs="trizen -Ss"
alias paci="trizen -S"
alias pacr="trizen -R"
alias pacrs="trizen -Rs"
alias pacu="trizen -Syyu"


# Wifi Monitor Mode for adapter that is not supported by aircrack-ng
alias monitor="sudo ifconfig wlan0 down && sleep 1 && sudo ip link set wlan0 name mon0 && sleep 1 && sudo iwconfig mon0 mode monitor && sleep 1 && sudo ifconfig mon0 up"
alias managed="sudo ifconfig mon0 down && sudo ip link set mon0 name wlan0 && sudo iwconfig wlan0 mode managed && sudo ifconfig wlan0 up"

# CLI weather in Cologne and weather in 'insert here'
alias weh='curl -s wttr.in/cologne | head -n-2'
alias wei='bash -c '\''curl -s wttr.in/$0 | head -n-2'\'''

# Pipe to and from clipboard
alias xc='xsel --clipboard --input'
alias xp='xsel --clipboard --output'
