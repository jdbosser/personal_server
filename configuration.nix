{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    
  ];

  # All of this was generated by nixos-infect 
  boot.cleanTmpDir = true;
  networking.hostName = "shark";
  networking.firewall.allowPing = true;

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCb7iMXzfXdsthehNDg+gbdBW44Basfy5635YkSBG13+0N07V4B5NDan1LxtYIAS7hIr42DQqscWD4YAcD2lDJBManNzOjLAmMy0qxIesCzkQE9xG1ZnRlYwWdliKxhLnlktV2zUI7fj6ZG0+kdNEaP/reeqOiXQrvtQ0td8a9QUztQ5sMkOCePEpcRaFS6qLsZBKIWfEtcD9eA3jyzm5z88PEl7M6JFV+ssSbCQfOA4npBvYlvXxAlPxTuXQG32ihXURJQAdQiPkUrCtyKZKwyXy52oMC0lpGzkX2PsLgMhxqXXb/0pzjGVYh6ncvmy9zxETP0xCRVvmvxyxXkrnT/ jibe@nixos"
  ];

  # My additions
  environment.systemPackages = with pkgs; [ neovim git ];

  # Setup firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Setup nginx
  services.nginx.enable = true;

  # Setup default virtualhost
  services.nginx.virtualHosts."142.93.229.40" = {
    root = "/root/server/test_website";
    default = true;
    listen = [ {addr = "142.93.229.40"; port = 80;} ];
    locations= {
    	"/" = {
		tryFiles = "$uri $uri/index.html";
	};
    };
};
  
}