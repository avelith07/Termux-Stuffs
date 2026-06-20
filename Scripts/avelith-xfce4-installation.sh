#!/data/data/com.termux/files/usr/bin/bash

# Color Definitions
BOLD_RED="\e[1;31m"
BOLD_YELLOW="\e[1;33m"
BOLD_CYAN="\e[1;36m"
BOLD_GREEN="\e[1;32m"
RESET="\e[0m"

#---------------------------------------

# Fixing errors & updating all packages
echo -e "${BOLD_YELLOW}Testing current mirror\nUpdating & Upgrading all packages...\nWill ask the user for input${RESET}"
sleep 1

pkg update || {
	echo "failed to update packges, change mirror"
	sleep 1
	termux-change-repo || { 
	echo "fix the mirror at first"
	exit 1
	}
}

pkg update > /dev/null 2>&1 || exit 1
pkg upgrade -y || {
	echo "failed to upgrade packages. Choose a up-to-date mirror or official mirror. Or remove conflicting packages"
	exit 1
}

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Core packages installation
echo -e "${BOLD_YELLOW}Installing necessary packges...\nWill take a few moments${RESET}"
sleep 1

pkg install -y x11-repo
pkg install -y termux-x11-nightly
pkg install -y tur-repo
pkg install -y termux-api
pkg install -y pulseaudio
pkg install -y proot-distro
pkg install -y rsync
pkg install -y micro
pkg install -y wget curl
pkg install -y which
pkg install -y git

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Setting up Hardware Acceleration
echo -e "${BOLD_YELLOW}Setting up hardware acceleration...\nWill take a few moments${RESET}"
sleep 1

while true; do
  echo -e "${BOLD_CYAN}What GPU do you have?${RESET}"
  echo -e "${BOLD_YELLOW}1) Mali with Vulkan-supported (HWA Supported)${RESET}"
  echo -e "${BOLD_YELLOW}2) Any other GPU (LLVMpipe — CPU-only)${RESET}"
  
  read -p "Enter your choice [1-2]: " choice

  case $choice in
    1)
      echo -e "${BOLD_YELLOW}Installing & Configuring HWA...${RESET}"
      pkg update > /dev/null 2>&1

      mkdir -p ~/Temp-HWA
      cd ~/Temp-HWA

      wget -O mesa-zink_23.0.4-5_aarch64.deb \
https://github.com/avelith07/Termux-Stuffs/releases/download/v23.0.4-5/mesa-zink_23.0.4-5_aarch64.deb

      wget -O mesa-zink-dev_23.0.4-5_aarch64.deb \
https://github.com/avelith07/Termux-Stuffs/releases/download/v23.0.4-5/mesa-zink-dev_23.0.4-5_aarch64.deb

      apt install -y ./*.deb
      apt --fix-broken install -y
      apt install -y virglrenderer-mesa-zink vulkan-loader-generic angle-android virglrenderer-android \
libandroid-shmem libc++ libdrm libx11 libxcb libxshmfence libwayland zlib zstd

      wget -O vulkan-icd.deb \
https://github.com/avelith07/Termux-Stuffs/releases/download/v25.0.0-2/vulkan-wrapper-android_25.0.0-2_aarch64.deb

      apt install -y ./vulkan-icd.deb
      apt --fix-broken install -y

      cd ~
      rm -rf ~/Temp-HWA

      pkg install -y glmark2
      pkg install -y vkmark

      mkdir -p ~/bin
      cd ~/bin

      wget -O termux-xfce4 \
https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/Startup%20Scripts/termux-xfce4-mali.sh

      chmod +x termux-xfce4
      cd ~

      break
      ;;
    2)
      echo -e "${BOLD_YELLOW}Skipping Hardware Acceleration${RESET}"
      sleep 1
      break
      ;;
    *)
      echo -e "${BOLD_RED}Invalid option, please try again!${RESET}"
      sleep 1
      ;;
  esac
done

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Browser Installation
echo -e "${BOLD_YELLOW}Installing a browser...\nWill take a while${RESET}"
sleep 1

while true; do
  echo -e "${BOLD_CYAN}Select Your Browser:${RESET}"
  echo -e "${BOLD_YELLOW}1) Firefox (recommended)${RESET}"
  echo -e "${BOLD_YELLOW}2) Chromium${RESET}"
  echo -e "${BOLD_YELLOW}3) Firefox and Chromium (both)${RESET}"

  read -p "Enter your choice [1-3]: " choice

  case $choice in
    1)
      echo -e "${BOLD_YELLOW}Installing Firefox...${RESET}"
      pkg install -y firefox
      echo -e "${BOLD_GREEN}Firefox Installed Successfully!${RESET}"
      break
      ;;
    2)
      echo -e "${BOLD_YELLOW}Installing Chromium...${RESET}"
      pkg install -y chromium
      echo -e "${BOLD_GREEN}Chromium Installed Successfully!${RESET}"
      break
      ;;
    3)
      echo -e "${BOLD_YELLOW}Installing Firefox and Chromium...${RESET}"
      pkg install -y firefox
      pkg install -y chromium
      echo -e "${BOLD_GREEN}Firefox and Chromium Installed Successfully!${RESET}"
      break
      ;;
    *)
      echo -e "${BOLD_RED}Invalid option. Please try again.${RESET}"
      ;;
  esac
done

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Video Player Installation
echo -e "${BOLD_YELLOW}Installing a video player (works for the audio as well)...\nWill take a while${RESET}"
sleep 1

while true; do
  echo -e "${BOLD_CYAN}Select Your Player:${RESET}"
  echo -e "${BOLD_YELLOW}1) VLC (recommended)${RESET}"
  echo -e "${BOLD_YELLOW}2) MPV (recommended for power users)${RESET}"
  echo -e "${BOLD_YELLOW}3) VLC & MPV (both)${RESET}"
  echo -e "${BOLD_YELLOW}4) Skip${RESET}"

  read -p "Enter your choice [1-4]: " choice

  case $choice in
    1)
      echo -e "${BOLD_YELLOW}Installing VLC...${RESET}"
      pkg install -y vlc-qt
      echo -e "${BOLD_GREEN}VLC Installed Successfully!${RESET}"
      break
      ;;
    2)
      echo -e "${BOLD_YELLOW}Installing MPV...${RESET}"
      pkg install -y mpv
      echo -e "${BOLD_GREEN}MPV Installed Successfully!${RESET}"
      break
      ;;
    3)
      echo -e "${BOLD_YELLOW}Installing VLC and MPV (both)...${RESET}"
      pkg install -y mpv
      pkg install -y vlc-qt
      echo -e "${BOLD_GREEN}VLC and MPV Installed Successfully!${RESET}"
      break
      ;;
    4)
      echo -e "${BOLD_YELLOW}Skipping Installation${RESET}"
      break
      ;;
    *)
      echo -e "${BOLD_RED}Invalid option. Please try again.${RESET}"
      ;;
  esac
done

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Setting up WaifuDownloader
if false; then
echo -e "${BOLD_YELLOW}WaifuDownloader Installation...\nWill take a few moments${RESET}"
sleep 1

while true; do
  echo -e "${BOLD_CYAN}Do you want to install WaifuDownloader?${RESET}"
  echo -e "${BOLD_YELLOW}1) Yes${RESET}"
  echo -e "${BOLD_YELLOW}2) No${RESET}"

  read -p "Enter your choice [1-2]: " choice

  case $choice in
    1)
      echo -e "${BOLD_YELLOW}Installing WaifuDownloader...${RESET}"
      pkg install -y python 
      pip install requests
      
      mkdir ~/WD-Wood
      cd ~/WD-Wood
      
      wget -O waifudownloader_0.2.10_aarch64.deb https://github.com/Prime-TITAN-CameraMan/Termux-Desktop/releases/download/v0.2.10/waifudownloader_0.2.10_aarch64.deb
      apt install -y ./waifudownloader_0.2.10_aarch64.deb
      
      cd ~
      rm -rf ~/WD-Wood
      sleep 1
      break
      ;;
    2)
      echo -e "${BOLD_YELLOW}Skipping installation...${RESET}"
      sleep 1
      break
      ;;
    *)
      echo -e "${BOLD_RED}Invalid option, please try again!${RESET}"
      sleep 1
      ;;
  esac
done

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear
fi

#---------------------------------------

# Setting up varianles, exports & scripts
echo -e "${BOLD_YELLOW}Setting up user friendly scripts & directories...\nWill take a few moments${RESET}"
sleep 1

touch ~/.bashrc
echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"

mkdir -p ~/bin
mkdir -p ~/.local/bin
rm -rf ~/Git-Ave
mkdir -p ~/Desktop ~/Downloads ~/Pictures ~/Temp ~/.config ~/Git-Ave

rm -rf ~/.vnx/xstartuo
mkdir -p ~/.vnc
touch ~/.vnc/xstartup

echo '#!/data/data/com.termux/files/usr/bin/sh' >> "$HOME/.vnc/xstartup"
echo 'unset SESSION_MANAGER' >> "$HOME/.vnc/xstartup"
echo 'unset DBUS_SESSION_BUS_ADDRES' >> "$HOME/.vnc/xstartup"

cd ~/bin
wget -O apphwa https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/apphwa
wget -O native_cleaner https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/native_cleaner
wget -O proot_program https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/proot_program
wget -O termux-fastest-repo https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/termux-fastest-repo
wget -O termux-multi-instance https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/termux-multi-instance
wget -O extract https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/extract
wget -O access-vnc https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/vnc-startup
wget -O .vnc-xfce4 https://raw.githubusercontent.com/avelith07/Termux-Stuffs/refs/heads/main/bin/vnc-xfce4

chmod +x apphwa
chmod +x native_cleaner
chmod +x proot_program
chmod +x termux-multi-instance
chmod +x termux-fastest-repo
chmod +x desktop-help
chmod +x extract
chmod +x access-vnc
chmod +x .vnc-xfce4

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Installing TigerVNC & WebSokify
echo -e "${BOLD_YELLOW}Installing WebSokify & VNC server...\nWill take a few moments${RESET}"
sleep 1

pkg install -y tigervnc
pkg install -y tigervnc-viewer

mkdir ~/Git-Temp
cd ~/Git-Temp

git clone https://github.com/novnc/websockify.git
cd websockify

pip install . --no-deps

cd ~
rm -rf ~/Git-Temp

cd ~/Git-TCM
git clone https://github.com/novnc/noVNC.git

cd ~

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# XFCE4 installation
echo -e "${BOLD_YELLOW}Installing XFCE4 Desktop Environment...\nWill take a while${RESET}"
sleep 1

pkg install -y xfce4

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# XFCE4 Goodies & Utilities installation
echo -e "${BOLD_YELLOW}Installing XFCE4 Goodies & useful utilities...\nWill take a few moments${RESET}"
sleep 1

pkg install -y xfce4-goodies
pkg install -y xfce4-whiskermenu-plugin
pkg install -y xfce4-battery-plugin
pkg install -y xfce4-cpugraph-plugin
pkg install -y xfce4-docklike-plugin
pkg install -y xfce4-genmon-plugin
pkg install -y xfce4-places-plugin
pkg install -y xfce4-pulseaudio-plugin
pkg install -y xfce4-screenshooter
pkg install -y xfce4-taskmanager
pkg install -y fastfetch
pkg install -y fakeroot
pkg install -y sl
pkg install -y mousepad
pkg install -y cava
pkg install -y xterm

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------


# Debian Installation
echo -e "${BOLD_YELLOW}Installing Debian...\nWill take a while${RESET}"
sleep 1

proot-distro install debian

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Debian Setup
echo -e "${BOLD_YELLOW}Installing essential packages in Debian...\nWill take a while (Depends on the server/mirror)${RESET}"
sleep 1

proot-distro login debian --shared-tmp -- /bin/bash << 'EOF'
apt update
apt upgrade -y
apt install -y sudo
apt install -y nano
apt install -y dbus-x11
apt install -y adduser
apt install -y pulseaudio
mkdir -p "$HOME/bin"
EOF

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Communication Apps
echo -e "${BOLD_YELLOW}Installing Communication Apps...\nWill take a while${RESET}"
sleep 1

while true; do
  echo -e "${BOLD_CYAN}Select Your App:${RESET}"
  echo -e "${BOLD_YELLOW}1) Discord (Vesktop/Vencord - PRoot)${RESET}"
  echo -e "${BOLD_YELLOW}2) Telegram${RESET}"
  echo -e "${BOLD_YELLOW}3) Discord & Telegram (both)${RESET}"
  echo -e "${BOLD_YELLOW}4) Skip${RESET}"

  read -p "Enter your choice [1-4]: " choice

  case $choice in
    1)
      echo -e "${BOLD_YELLOW}Installing Discord...${RESET}"

proot-distro login debian --shared-tmp -- /bin/bash << 'EOF'
apt update
apt install -y wget
wget -O vestop_1.6.5_arm64.deb https://github.com/Vencord/Vesktop/releases/download/v1.6.5/vesktop_1.6.5_arm64.deb
apt install -y ./vesktop_1.6.5_arm64.deb
apt --fix-broken install -y
rm -rf vesktop_1.6.5_arm64.deb
EOF

      echo -e "${BOLD_GREEN}Discord Installed Successfully!${RESET}"
      break
      ;;
    2)
      echo -e "${BOLD_YELLOW}Installing Telegram...${RESET}"

      pkg install -y telegram-desktop

      echo -e "${BOLD_GREEN}Telegram Installed Successfully!${RESET}"
      break
      ;;
    3)
      echo -e "${BOLD_YELLOW}Installing Discord and Telegram...${RESET}"

proot-distro login debian --shared-tmp -- /bin/bash << 'EOF'
apt update
apt install -y wget
wget -O vesktop_1.6.5_arm64.deb https://github.com/Vencord/Vesktop/releases/download/v1.6.5/vesktop_1.6.5_arm64.deb
apt install -y ./vesktop_1.6.5_arm64.deb
apt --fix-broken install -y
rm -rf vesktop_1.6.5_arm64.deb
EOF

      pkg install -y telegram-desktop

      echo -e "${BOLD_GREEN}Discord and Telegram Installed Successfully!${RESET}"
      break
      ;;
    4)
      echo -e "${BOLD_YELLOW}Skipping Installation${RESET}"
      break
      ;;
    *)
      echo -e "${BOLD_RED}Invalid option. Please try again.${RESET}"
      ;;
  esac
done

echo -e "${BOLD_GREEN}Done...${RESET}"
sleep 1.5
clear

#---------------------------------------

# Final
echo -e "${BOLD_CYAN}Congratulations, it's done. Now kill & restart your Termux.${RESET}" 
echo
echo -e "${BOLD_CYAN}Run \"desktop-help\" to know all necessary commands to operate the desktop.${RESET}"

exit 0
