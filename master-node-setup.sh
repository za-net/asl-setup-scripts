# Update current packages
sudo apt && sudo update

# Get Dependencies
sudo apt install htop curl wget git nethogs vnstat net-tools duf fail2ban gzip 

# Get Wireshard
curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh

# Get Linux Kernel Headers
# Should be as easy as sudo apt install linux-headers-amd64

# or even better - sudo apt install linux-headers-generic
# Installing the 'generic' package will also install the headers appropriate for your running kernel version but also will assure that updates to your kernel version will also trigger corresponding updates to the headers package.

# Manual install headers
wget https://ftp.debian.org/debian/pool/main/l/linux-signed-amd64/linux-headers-amd64_6.1.99-1_amd64.deb
sudo dpkg -i linux-headers-amd64_6.1.99-1_amd64.deb

# Docker for Debian
## Remove unecessary packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

## Add Repo
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Setup Nginx Proxy Manager
mkdir ~/nginxproxymanager
echo "services:\n  app:\n    image: 'jc21/nginx-proxy-manager:latest'\n    restart: unless-stopped\n    ports:\n      # These ports are in format <host-port>:<container-port>\n      - '80:80' # Public HTTP Port\n      - '443:443' # Public HTTPS Port\n      - '81:81' # Admin Web Port\n      # Add any other Stream port you want to expose\n      # - '21:21' # FTP\n    environment:\n      # Mysql/Maria connection parameters:\n      DB_MYSQL_HOST: "db"\n      DB_MYSQL_PORT: 3306\n      DB_MYSQL_USER: "npm"\n      DB_MYSQL_PASSWORD: "npm"\n      DB_MYSQL_NAME: "npm"\n      # Uncomment this if IPv6 is not enabled on your host\n      # DISABLE_IPV6: 'true'\n    volumes:\n      - ./data:/data\n      - ./letsencrypt:/etc/letsencrypt\n    depends_on:\n      - db\n\n  db:\n    image: 'jc21/mariadb-aria:latest'\n    restart: unless-stopped\n    environment:\n      MYSQL_ROOT_PASSWORD: 'npm'\n      MYSQL_DATABASE: 'npm'\n      MYSQL_USER: 'npm'\n      MYSQL_PASSWORD: 'npm'\n      MARIADB_AUTO_UPGRADE: '1'\n    volumes:\n      - ./mysql:/var/lib/mysql\n" > ~/nginxproxymanager/docker-compose.yml
cd  ~/nginxproxymanager
docker compose up -d

# Add ASL Repo
cd /tmp
wget https://repo.allstarlink.org/public/asl-apt-repos.deb12_all.deb
sudo dpkg -i asl-apt-repos.deb12_all.deb
sudo apt update

# ASL Packages
sudo apt install asl3
