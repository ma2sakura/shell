{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    awscli2
    s3fs
  ];
}