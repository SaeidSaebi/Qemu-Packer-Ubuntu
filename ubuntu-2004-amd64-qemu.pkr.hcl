"builders": [
    {
      "type": "qemu",
      "iso_checksum": "{{user `iso_checksum`}}",
      "iso_url": "{{user `iso_url`}}",
      "disk_size": "{{user `disk_size`}}",
      "disk_image": true,
      "format": "qcow2",
      "disk_compression": true,
      "headless": false,
      "output_directory": "output-ubuntu",
      "shutdown_command": "echo '{{user `ssh_password`}}' | sudo -t -S /sbin/shutdown -P now",
      "ssh_password": "{{user `ssh_password`}}",
      "ssh_timeout": "45m",
      "ssh_username": "{{user `ssh_username`}}",
      "ssh_pty": true,
      "ssh_handshake_attempts": "20",
      "vm_name": "{{user `name`}}{{user `version`}}.qcow2",
      "accelerator": "kvm",
      "use_default_display": true,
      "vnc_bind_address": "0.0.0.0"
    }
  ],
source "qemu" "ubuntu-2004-amd64-qemu" {
  vm_name           = "ubuntu-2004-amd64-qemu-build"
  iso_url           = "https://releases.ubuntu.com/focal/ubuntu-20.04.6-live-server-amd64.iso"
  iso_checksum      = "sha256:b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
  memory            = 1024
  disk_image        = false
  output_directory  = "output-ubuntu-2004-amd64-qemu"
  accelerator       = "kvm"
  disk_size         = "5000M"
  disk_interface    = "virtio"
  format            = "qcow2"
  net_device        = "virtio-net"
  boot_wait         = "3s"
  boot_command      = [
    # Make the language selector appear...
    " <up><wait>",
    # ...then get rid of it
    " <up><wait><esc><wait>",

    # Go to the other installation options menu and leave it
    "<f6><wait><esc><wait>",

    # Remove the kernel command-line that already exists
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",

    # Add kernel command-line and start install
    "/casper/vmlinuz ",
    "initrd=/casper/initrd ",
    "autoinstall ",
    "ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu-2004-amd64-qemu/ ",
    "<enter>"
    ]
  http_directory    = "http-server"
  shutdown_command  = "echo 'packer' | sudo -S shutdown -P now"
  ssh_username      = "ubuntu"
  ssh_password      = "ubuntu"
  ssh_timeout       = "60m"
}

#build {
#  sources = ["source.qemu.ubuntu-2004-amd64-qemu"]

  #provisioner "file" {
  #  sources     = [ "provisioning/first-config",
  #                  "provisioning/second-config"]
  #  destination = "/home/ubuntu/"
  #}

  #provisioner "shell" {
  #  script          = "provisioning/init.sh"
  #  execute_command = "sudo bash {{.Path}}"
  #}}