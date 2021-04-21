{ pkgs ? import <nixpkgs> { } }:
with pkgs;
buildGoModule
rec {
  pname = "ical-to-diary";
  version = "0.1.0";
  vendorSha256 = "0vf747w7z7drh5kgfs2s3851wgnkpvwpbzz43ism967akgql7jyh";

  src = ./.;
}
