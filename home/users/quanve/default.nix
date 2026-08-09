{ ... }:
{
  # Modules enabled for this user on every host.
  # Host-specific modules are enabled in ./host-specific/<hostname>/default.nix.
  myHome.modules = {
    comms = {
      telegram.enable = true;
      obsidian.enable = true;
      discord.enable = true;
    };

    core = {
      terminal.enable = true;
      editors.enable = true;
    };

    dev = {
      git = {
        enable = true;
        userName = "quanve";
        userEmail = "quanvepluxary@proton.me";
      };
      development.enable = true;
    };

    utils = {
      utilities.enable = true;
      utilities-system.enable = true;
      file-management.enable = true;
      nixvim.enable = true;
    };
  };
}
