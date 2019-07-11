# https://www.marksei.com/how-to-vpn-wireguard/

echo "Fetching repo..."
sudo curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo

echo "Update..."
sudo yum install epel-release

echo "Installation..."
sudo yum install wireguard-dkms wireguard-tools

echo "verification..."
sudo modprobe wireguard 

if [ $? -ne 0 ]; then
    echo "Installation failed"
    exit
fi

echo "Generating pub/priv key pair..."
sudo mkdir /etc/wireguard
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey


sudo ip link add dev wg0 type wireguard
sudo ip addr add dev wg0 10.146.0.2
sudo wg set wg0 listen-port 51820
sudo wg set wg0 private-key /etc/wireguard/privatekey
