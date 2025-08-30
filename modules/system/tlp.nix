# TLP: force AC profile (max performance), even on battery
{ config, pkgs, ... }:
{
  # Do NOT run power-profiles-daemon alongside TLP
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      # --- Force AC mode no matter what power source is connected ---
      TLP_DEFAULT_MODE = "AC";
      TLP_PERSISTENT_DEFAULT = 1;   # ignore autoswitch; always use AC profile

      # --- CPU / Platform performance ---
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_HWP_ON_AC = "performance";      # for Intel HWP
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_BOOST_ON_AC = 1;                # Intel Turbo / AMD boost on
      PLATFORM_PROFILE_ON_AC = "performance";

      # --- PCIe / SATA / Runtime PM (disable powersave for perf) ---
      PCIE_ASPM_ON_AC = "performance";
      SATA_LINKPWR_ON_AC = "max_performance";
      RUNTIME_PM_ON_AC = "off";           # no autosuspend of PCI devices

      # --- Graphics (leave safe; uncomment if you know your GPU) ---
      # Intel iGPU: nothing needed here
      # AMD dGPU (old radeon): 
      # RADEON_DPM_STATE_ON_AC = "performance";
      # RADEON_POWER_PROFILE_ON_AC = "high";
      # amdgpu (newer):
      # AMDGPU_DPM_STATE_ON_AC = "performance";
      # AMDGPU_ABM_LEVEL_ON_AC = -1;

      # --- I/O scheduler & disks ---
      DISK_APM_LEVEL_ON_AC = "254 254";   # max performance (disable APM)
      DISK_IOSCHED = "mq-deadline";       # good default; try "none"/"kyber" if you prefer
      # DISK_DEVICES = "nvme0n1 sda";     # set explicitly if you want

      # --- USB / Audio / Wi-Fi powersave OFF for responsiveness ---
      USB_AUTOSUSPEND = 0;
      SOUND_POWER_SAVE_ON_AC = 0;
      WIFI_PWR_ON_AC = "off";
      # WOL_DISABLE = 0;                  # keep Wake-on-LAN if you want

      # --- Misc (don’t kill laptop battery unless you intend to) ---
      NMI_WATCHDOG = 1;                   # leave on; set 0 only for power saving

      # --- Battery charge thresholds (ThinkPads) ---
      # set both BAT0 and BAT1 in case machine has 2 batteries
      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0  = 100;

      START_CHARGE_THRESH_BAT1 = 0;
      STOP_CHARGE_THRESH_BAT1  = 100;
    };
  };
}
