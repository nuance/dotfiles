{ ... }:
{
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.nvidiaPersistenced = true;
}
