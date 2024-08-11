{ config, lib, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      # Make sure to use the correct Bus ID values for your system!
      # intelBusId = "";
      nvidiaBusId = "PCI:0:1:0";
      amdgpuBusId = "PCI:0:5:0";
    };
  };
}
