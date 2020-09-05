{ config, ... }:

{
  networking.firewall.trustedInterfaces = [ "wg0" ];

  #networking.wireguard.interfaces = {
  #  wg0 = {
  #    ips = [ "192.168.42.3/24" "2001:41d0:1004:1629:1337:187:1:3/120" ];
  #    privateKeyFile = config.krops.secrets.files."wg0.key".path;
  #    peers = [{
  #      publicKey = "MUsPCkTKHBGvCI62CevFs6Wve+cXBLQIl/C3rW3PbVM=";
  #      allowedIPs = [
  #        "10.0.0.0/24"
  #        "192.168.42.0/24"
  #        "2001:41d0:1004:1629:1337:187:1:0/120"
  #        "2001:41d0:1004:1629:1337:187:0:1/128"
  #      ];
  #      endpoint = "51.254.249.187:51820";
  #      persistentKeepalive = 21;
  #      presharedKeyFile = config.krops.secrets.files."wg0.psk".path;
  #    }];
  #  };
  #};

  systemd.network.netdevs."30-wg0" = {
    netdevConfig = {
      Kind = "wireguard";
      Name = "wg0";
    };
    wireguardConfig = {
      FirewallMark = 51820;
      PrivateKeyFile = config.krops.secrets.files."wg0.key".path;
    };
    wireguardPeers = [{
      wireguardPeerConfig = {
        AllowedIPs = [ "0.0.0.0/0" "::/0" ];
        PublicKey = "UoIRXpG/EHmDNDhzFPxZS18YBlj9vBQRRQZMCFhonDA=";
        PersistentKeepalive = 21;
        Endpoint = "195.39.247.6:51820";
      };
    }];
  };
  systemd.network.networks."30-wg0" = {
    name = "wg0";
    linkConfig = { RequiredForOnline = "yes"; };
    addresses = [{
      addressConfig.Address = "192.168.242.102/24";
    }
    #{ addressConfig.Address = "2001:41d0:1004:1629:1337:187:1:3/112"; }
      ];
    routes = [{
      routeConfig.Destination = "192.168.242.0/24";
    }
    #{ routeConfig.Destination = "10.0.0.0/24"; }
      ];
  };

  networking.hosts = {
    # "10.0.0.2" = [ "io.yougen.de" "git.yougen.de" ];
    # "10.0.0.5" = [ "grafana.yougen.de" "hydra.yougen.de" "lycus.yougen.de" ];
  };

  users.users.systemd-network.extraGroups = [ "keys" ];
  krops.secrets.files."wg0.key".owner = "systemd-network";
}
