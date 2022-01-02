# NixOS 21.05 / Unstable Configuration
# Make sure to link the machine you want to use from the machines folder

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Common configuration for my machines
      # (hardware-configuration.nix is auto-gen)
      ./hardware-configuration.nix
#      ./networking.nix
      ./pkgs.nix
      ./services.nix
      ./boot.nix
      # Symlink from machines/name.nix
      # too lazy for flakes or modules
      ./machine.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # nix.maxJobs = lib.mkForce 8;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # pinyin input
  i18n.inputMethod = {
   enabled = "fcitx";
   fcitx.engines = with pkgs.fcitx-engines; [ cloudpinyin libpinyin];
  };
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.szhou= {
     isNormalUser = true;
     description = "Bytee";
     shell = pkgs.zsh;
     extraGroups = [ "wheel" "video" "networkmanager" "kvm" "libvirtd" "audio" "docker" "adbusers" "qemu-libvirtd" "audio" "disk" "networkmanager"];
  };

  security.sudo.wheelNeedsPassword = false;
  users.extraUsers.root.shell = pkgs.zsh;

  # Environment variables
  environment.variables.GTK_THEME = "Adwaita:dark";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

