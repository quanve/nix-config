{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      m = "micro";
      nix-rebuild = "doas nixos-rebuild switch";
    };

    sessionVariables = {
      EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      format = "$username$hostname$directory$git_branch$character";

      username = {
        show_always = true;
        format = "[$user]($style)@";
        style_user = "#a6e3a1";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "#cdd6f4";
      };

      directory = {
        format = "[$path]($style)";
        style = "#a6e3a1";
        truncation_length = 0;
        home_symbol = "~";
      };

      git_branch = {
        format = " [\\($branch\\)]($style)";
        style = "#cdd6f4";
      };

      character = {
        success_symbol = "[>](#cdd6f4)";
        error_symbol = "[>](#f38ba8)";
      };
    };
  };
}
