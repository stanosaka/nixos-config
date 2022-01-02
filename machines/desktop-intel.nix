# This contains setting which are different per machine
# Desktop PC (Ryzen 5950X, 128 GB Memory, 2 TB NVME, Radeon 5700 XT, Radeon 6600 XT)

{ config, pkgs, ... }:

{
  # Video Driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Networking
  networking = {
    hostName = "k6-nixos";
    domain = "local.cwzhou.win";
    useDHCP = false;
    interfaces.enp6s0.ipv4.addresses = [{
        address = "192.168.199.19";
        prefixLength = 28;
      }];
    defaultGateway = "192.168.199.1";
    nameservers = [ "192.168.199.20" "192.168.199.8" ];
    networkmanager.enable = true;
     i18n = {
       consoleFont = "Lat2-Terminus16";
       consoleKeyMap = "us";
       defaultLocale = "en_US.UTF-8";
     };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
