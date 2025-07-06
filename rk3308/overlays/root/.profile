date --set="Sun Jul  6 01:07:31 AM CDT 2025"
export FZF_DEFAULT_COMMAND="ls"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"
export TERM=xterm-256color
mount -t debugfs none /sys/kernel/debug
resize


echo none > /sys/class/leds/green:heartbeat/trigger

ColoredPrint() {
    case "$1" in
        red*)       color='\033[0;31m'  ;;
        orange*)    color='\033[0;33m'  ;;
        green*)     color='\033[0;32m'  ;;
        cyan*)      color='\e[96m'      ;;
        yellow*)    color='\e[33m'      ;;
        blue*)      color='\e[34m'      ;;
        magenta*)   color='\e[35m'      ;;
        *)          color='\033[0m\e[0m';;
    esac
    nocolor='\033[0m\e[0m\e[0m'
    shift
    case "$1" in
        ul*)    modifier='\e[4m'    ;;
        inv*)   modifier='\e[7m'    ;;
        bold*)  modifier='\e[1m'    ;;
        *)      modifier='\e[0m'    ;;
    esac
    shift
    printf "${color}${modifier}$@${nocolor}\n"
}

freeram() {
    before=$(free -m | grep Mem: | awk '{print $3}')
    sync
    echo 1 > /proc/sys/vm/drop_caches
    after=$(free -m | grep Mem: | awk '{print $3}')
    echo "RAM before: " $before
    echo "RAM after:  " $after
    echo "RAM saved:  $(( $before - $after))"
}

function mkd() { mkdir -p "$1" && cd "$1"; }
function up() {
  if [ $# -le 0 ]; then
    steps=1
  else
    steps="$1"
  fi
  string=""
  for i in $(seq 1 $steps); do
    string="$string../"
  done
  cd "$string"
}

left_pad()   { C=$((COLUMNS - 1)); sed -e :a -e "s/^.\{1,$C\}$/& /;ta"; }
right_pad()  { C=$((COLUMNS - 1)); sed -e :a -e "s/^.\{1,$C\}$/ &/;ta"; }
center_pad() { C=$((COLUMNS - 1)); sed -e :a -e "s/^.\{1,$C\}$/ & /;ta"; }
ff() { #find file
  if [ -z "${2}" ]; then
    find . -type f -iname "*${1}*" 
  else
    find . -type f -maxdepth "${2}" -iname "*${1}*" 
  fi
}

fd() { #find directory
  if [ -z "${2}" ]; then
    find . -type d -iname "*${1}*" 
  else
    find . -type d -maxdepth "${2}" -iname "*${1}*" 
  fi
}

vf() {  vim "$(ff "$@" | fzf)"; }
cf() { cat "$(ff "$@" | fzf)"; }

wifi() {
  modprobe brcmfmac_bca # the one that works well enough
  gpioset gpiochip0 5=0 # external antenna GPIO
  wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
  udhcpc -i wlan0
  #wget --no-check-certificate https://link.testfile.org/500MB
}

hotspot() {
  modprobe brcmfmac_bca # the one that works well enough
  gpioset gpiochip0 5=0 # external antenna GPIO
  gun wpa_supplicant
  gun udhcpc
  rm -rf /run/wpa_supplicant
cat > /etc/hostapd.conf << EOF
interface=wlan0
channel=6
ieee80211n=1
hw_mode=g
ssid2=f09f939a204c6974746c652046726565204c69627261727920f09f939a
EOF
  hostapd /etc/hostapd.conf &
  ip link set wlan0 up
  ifconfig wlan0 192.168.100.1
  /etc/init.d/S80dnsmasq restart
}

zram_swap() {
  # Create 256MB of zram, 4 threads, zstd compression
  zramctl /dev/zram0 -s 256M -t 4 -a zstd
  mkswap  /dev/zram0
  swapon /dev/zram0
}



function gf() {
  local thisfile=( $(grep -irHn "$@" * | fzf | awk -F':' '{print $1, "+"$2  }' ) )
  if [ "$thisfile" ]; then
      vim "${thisfile[0]}"  "${thisfile[1]}"
  fi
}
lst() {
    local input="$1"
    if [ -n "$input" ] && [ "$input" -eq "$input" ] 2>/dev/null; then
        list_number="$input"
    else
        dir="${1:-.}"
    fi
    local dir="${dir:-.}"
    local list_number="${list_number:-3}"
    #echo "${dir} ${list_number}"
    ls -t "${dir}" | head -n "${list_number}"
}

cpuspeed() {
  temp=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq | awk '{printf ("%0.0f",$1/1000); }' )
  if [ "${#temp}" -ge 4 ]; then
    echo $temp | awk '{printf ("%0.3f %s",$1/1000, "GHz"); }'
  else
    echo -ne "$temp MHz"
  fi
}

cputemp() { 
  awk '{printf ("%0.1f %s",$1/1000, "C")}'  /sys/devices/virtual/thermal/thermal_zone1/temp;
}

strip() { awk '{$1=$1};1'; }

function memhog() {
  ps aux  | awk '{print $6/1024 " MB\t\t" $11}'  | sort -n -r | grep -v "\[" | less
}

bigfiles() {
  du -h | sort -hr | head -n20
}

gun() {
  #Kill any process that matches name, like killall but better!
  pids=($(pgrep -af "$@" | awk '{print $1}'))
  for p in "${pids[@]}"; do
    kill -9 "$p"
  done
}

wherethefuck () 
{ 
    local previous_dir=$(pwd);
    cd /;
    find . \( -path './sys' -o -path './proc' -o -path './dev' \) -prune -o -type f -iname "*${1}*" -print 2> /dev/null;
    cd "$previous_dir"
}

freboot() {
    echo 1 > /proc/sys/kernel/sysrq
    echo s > /proc/sysrq-trigger
    echo b > /proc/sysrq-trigger
}

dts_to_dtb() {
        local INPUT="$1"
        INPUT="${INPUT%%.*}"
        dtc -O dtb -o "$INPUT".dtb "$INPUT".dts
}

dtb_to_dts() {
        local INPUT="$1"
        INPUT="${INPUT%%.*}"
        dtc -O dts -o "$INPUT".dts "$INPUT".dtb
}

function dtsconvert() {
  local input_file="$@"
  local extension="${input_file##*.}"
  local file_name="${input_file%.*}"
  if [[ "$extension" == "dtb" ]]; then
    output_extension="dts"
    dtc -I dtb -O dts -f "$input_file" -o "$file_name.$output_extension"
  elif [[ "$extension" == "dts" ]]; then
    output_extension="dtb"
    dtc -I dts -O dtb -f "$input_file" -o "$file_name.$output_extension"
  else
    echo "I only take dts or dtb files"
  fi
}

list_tcp_connections() {  lsof -i tcp; }
list_tcp_ports() { lsof -iTCP -sTCP:LISTEN -P -n ; }

strace_open_files() {
  strace -o /tmp/strace.log -f -t -e  trace=file "$@"
  echo "Log output for strace in /tmp/strace.log"
}

# https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem#menuconfig
run_idle_cpu_only() { ionice -c 3 chrt --idle 0 nice -n19 "$@"; }

