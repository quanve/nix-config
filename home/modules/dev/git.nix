{ config, lib, ... }:
let
  cfg = config.myHome.modules.dev.git;
in
{
  options.myHome.modules.dev.git = {
    enable = lib.mkEnableOption "dev/git";

    # Per-user variants: every user sets their own identity.
    userName = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Git user.name for this user";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Git user.email for this user";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = cfg.userName;
        email = cfg.userEmail;
      };
    };
  };
}
