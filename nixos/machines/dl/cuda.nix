{ pkgs, ... }:
{
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.nvidiaPersistenced = true;

  environment.systemPackages = with pkgs; [
    cudatoolkit_11
  ];
}
