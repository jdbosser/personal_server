{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {

	nixosModule = (
	
	let 
	
	vHost = { root = ./test_website;
	    forceSSL = true;
	    enableACME = true;
	    locations= {
		"/" = {
			tryFiles = "$uri $uri/index.html";
		};
	    };
	};
	in
	{config, ...} : 
	{
		
			
	config.security.acme.email = "john.daniel@bosser.com";
	config.security.acme.acceptTerms = true;

	# Setup nginx
	config.services.nginx.enable = true;

	# Setup default virtualhost
	config.services.nginx.virtualHosts = {
	      # "192.168.0.24" = vHost;
	      "bosser.se" = vHost;
	      "www.bosser.se" = vHost;
	      # "johndaniel.work" = vHost;
	      # "www.johndaniel.work" = vHost;
	      # "johndaniel.engineer" = vHost;
	      # "www.johndaniel.engineer" = vHost;
	};

	
	});

	

  };
}
