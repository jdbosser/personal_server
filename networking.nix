{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "67.207.67.3"
      "67.207.67.2"
    ];
    defaultGateway = "142.93.224.1";
    defaultGateway6 = "";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="142.93.229.40"; prefixLength=20; }
{ address="10.18.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::70e1:acff:fe85:755d"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "142.93.224.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 32; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="72:e1:ac:85:75:5d", NAME="eth0"
    
  '';
}
