# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/98e7e7ee-413d-46e7-bb36-1eee3e87a920";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9cf0a081-be64-4058-ae93-4909aee6458c";
    fsType = "ext2";
  };

  fileSystems."/persist/log" = {
    device = "/dev/disk/by-uuid/93b427f7-50e3-45a4-81d6-4492ec9c3f36";
    fsType = "xfs";
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/persist/log";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
  };

  fileSystems."/persist/secrets" = {
    device = "/dev/disk/by-uuid/a554f589-5ac0-487d-ae6d-e63d3139e6a4";
    fsType = "xfs";
    neededForBoot = true;
  };

  fileSystems."/var/src/secrets" = {
    device = "/persist/secrets";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
  };

  fileSystems."/persist/data" = {
    device = "/dev/disk/by-uuid/3d9bf742-b5c0-4bbd-b038-9537f3a4d6f7";
    fsType = "xfs";
  };

  fileSystems."/home" = {
    device = "/persist/data/home";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/67a99eef-bd7f-44cd-b197-95589e50bf5c";
    fsType = "xfs";
    neededForBoot = true;
    options = [ "noatime" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/375f0101-104b-4643-a6c1-1d66d5c1a067"; }];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}