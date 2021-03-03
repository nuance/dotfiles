{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cudatoolkit_11
  ];
}
