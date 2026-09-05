{ ... }:
{
  myHome.modules = {
    comms = {
      telegram.enable = true;
      obsidian.enable = true;
      vesktop.enable = true;
    };

    core = {
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
    };
  };
}
