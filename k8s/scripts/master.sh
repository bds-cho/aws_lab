#!/bin/bash -xe

# common
apt update -y && apt upgrade -y
hostnamectl set-hostname master
swapoff -a
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl --system
apt-get -y install containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd && systemctl enable containerd
apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update && apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# master
kubeadm config images pull
kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p /root/.kube
cp /etc/kubernetes/admin.conf /root/.kube/config
chown $(id -u):$(id -g) /root/.kube/config

# Install Calico CNI
for i in {1..30}; do
  sudo kubectl version && break
  echo "Waiting for API server..."
  sleep 5
done
sudo kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.4/manifests/tigera-operator.yaml --validate=false
sleep 30
sudo kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.4/manifests/custom-resources.yaml --validate=false
