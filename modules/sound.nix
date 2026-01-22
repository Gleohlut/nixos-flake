{ ... }:
{
  # Sound
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
