source "qemu" "ubuntu_iso" {
  iso_url   = "https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso" 
  iso_checksum = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"          
  format    = "iso"
  boot_command = [
    "<enter><wait>",
    "/install/vmlinuz",
    "initrd=/install/initrd.gz",
    "auto-install/enable=true",
    "debconf/priority=critical",
    "debian-installer/locale=en_US",
    "keyboard-configuration/layoutcode=us",
    "netcfg/get_domain=example.org",
    "netcfg/get_hostname=ubuntu",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
    "-- <enter>"
  ]
}

build {
  sources = ["source.qemu.ubuntu_iso"]

  provisioner "shell" {
    inline = [
      "sleep 30",  # Wait for the installation to complete
    ]
  }
}
