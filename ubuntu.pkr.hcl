{
  "builders": [
    {
      "boot_command": [
        "<enter><wait><f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
        "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
        "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
        "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
        "/install/vmlinuz<wait>",
        " initrd=/install/initrd.gz<wait>",
        " auto<wait>",
        " console-setup/ask_detect=false<wait>",
        " console-setup/layoutcode=us<wait>",
        " console-setup/modelcode=pc105<wait>",
        " debconf/frontend=noninteractive<wait>",
        " debian-installer=fr_FR<wait>",
        " fb=false<wait>",
        " kbd-chooser/method=fr<wait>",
        " keyboard-configuration/layout=FR<wait>",
        " keyboard-configuration/variant=FR<wait>",
        " locale=fr_FR<wait>",
        " netcfg/get_domain={{user `domain`}}<wait>",
        " netcfg/get_hostname={{user `hostname`}}<wait>",
        " grub-installer/bootdev=/dev/sda<wait>",
        " noapic<wait>",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
        " -- <wait>",
        " <enter><wait>"
      ],
      "cpus": "1",
      "disk_size": "8000",
      "format": "ova",
      "guest_additions_mode": "upload",
      "guest_os_type": "Ubuntu_64",
      "headless": "false",
      "http_directory": "http",
      "iso_checksum_type": "sha256",
      "iso_checksum": "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd",
      "iso_target_path": "./iso/ubuntu-18.04.2-server-amd64.iso",
      "iso_url": "https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso",
      "memory": "1024",
      "shutdown_command": "echo {{user `ssh_pass`}} | sudo -S shutdown -P now",
      "ssh_password": "{{user `ssh_pass`}}",
      "ssh_timeout": "20m",
      "ssh_username": "{{user `ssh_user`}}",
      "ssh_wait_timeout": "5000s",
      "type": "virtualbox-iso",
      "vm_name": "xavki"
    }
  ],

  "provisioners": [{
    "type": "shell",
    "inline": [
    "if [ ! -z '{{ user `valeur_cond`}}' ]; then echo '{{ user `valeur_cond`}}' > hello.txt; fi"
    ]
  }],
  "variables": {
    "domain": "local",
    "hostname": "xavki",
    "ssh_pass": "vagrant",
    "ssh_user": "vagrant",
    "valeur_cond": "hello xavki !!!"
  }
}

