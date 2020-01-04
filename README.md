# Get a nixos machine on digital ocean
Run [nixos-infect][1]. It can be done with the following command as root on an ubuntu 16.04 machine:
```
    git clone https://github.com/elitak/nixos-infect
    sudo ./nixos-infect/nixos-infect
```
You will probably be kicked out from the server due to ssh not trusting it anymore. On your machine that has connected to digital ocean, run 
```
    ssh-keygen -R <host>
```
So for example 
```
    ssh-keygen -R 192.168.3.10
```
if your digital ocean server has the ip `192.168.3.10`. [Source][2].

# Documentation on how I went about setting up configuration.nix

## Setup nginx
In your `/etc/nixos/configuration.nix` file, add the following:
```
  # Setup firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Setup nginx
  services.nginx.enable = true;
```
which is pretty self explanatory to get nginx up and running. 

### Setup defualt virtualHost
Setting up a virtualHost to be accessed from the normal ip adress was a little bit more difficult than expected, but ended up with only a handful of files. First, I created a simple website in a folder `test_website/index.html` containing
```
    <h1> Hej och välkommen! </h1>
```
which in English translates to "Hello and welcome!". Next, I made sure that nginx has access to the file. It seems lite nginx needs to have read access in the whole file tree. In my case, I located the test website in `/root/server/test_website`. Thus, giving all applications and groups read permission in `/root` will let nginx see the test website. **This is probably not a really good idea. Could be better to place the website in `/etc/www` like most people do**. 
```
    chmod -R 755 /root
```
Next, we declare a virtualHost in the `configuration.nix`-file:
```
  # Setup default virtualhost
  services.nginx.virtualHosts.<ip> = {
    root = "/root/server/test_website";
    default = true;
    listen = [ {addr = "<ip>"; port = 80;} ];
    locations= {
        "/" = {
                tryFiles = "$uri $uri/index.html";
        };
    };
  };
```
Which line by line is
1. A comment
2. Where the files for the test website are located
3. If someone visits the ip for the server, this is the website to display. **Do not know if this is needed when the virtualHost name is the ip.**
4. The server listens for requests on the ip adress on the default port. 
5. If someone visits the ip directly, make sure we return the index.html file. 

[1]: https://github.com/elitak/nixos-infect
[2]: https://stackoverflow.com/questions/20840012/ssh-remote-host-identification-has-changed
