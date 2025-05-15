#!/bin/bash

# Install tools
echo "Installing neofetch, figlet, and lolcat..."
apt update -y
apt install -y neofetch figlet lolcat wget

# Tambah font slant jika belum ada
FONT_DIR="/usr/share/figlet"
if [ ! -f "$FONT_DIR/slant.flf" ]; then
    echo "Downloading slant font..."
    wget -q http://www.figlet.org/fonts/slant.flf -O "$FONT_DIR/slant.flf"
fi

# Buat file MOTD
MOTD_FILE="/etc/profile.d/motd.sh"
echo "Creating custom MOTD at $MOTD_FILE"

cat > "$MOTD_FILE" << 'EOF'
#!/bin/bash
clear
echo "======================================" | lolcat
figlet -f slant "skyzxu" | lolcat
echo "======================================" | lolcat
echo "Hostname : $(hostname)" | lolcat
echo "Date     : $(date)" | lolcat
echo "Uptime   : $(uptime -p)" | lolcat
echo "Users    : $(who | wc -l) Logged In" | lolcat
echo "--------------------------------------" | lolcat
neofetch | lolcat
echo "--------------------------------------" | lolcat
echo "Stay Awesome & Keep Building!" | lolcat
echo "======================================" | lolcat
EOF

# Buat bisa dieksekusi
chmod +x "$MOTD_FILE"

echo "MOTD berhasil diatur! Silakan login ulang atau jalankan:"
echo "bash /etc/profile.d/motd.sh"
