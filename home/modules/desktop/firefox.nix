{ config, lib, ... }:
let
  cfg = config.myHome.modules.desktop.firefox;
in
{
  options.myHome.modules.desktop.firefox.enable = lib.mkEnableOption "desktop/firefox";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      Preferences = {
        # Passwords
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;

        "signon.firefoxRelay.feature" = "";
        "signon.management.page.breach-alerts.enabled" = false;

        # Autofill
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";

        # History
        "places.history.enabled" = false;
        "browser.history_expire_days" = 0;
        "privacy.clearOnShutdown.history" = true;

        "browser.formfill.enable" = false;
        "browser.sessionstore.privacy_level" = 2;

        # Resist fingerprinting
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.letterboxing" = true;
        "general.platform.override" = "Win32";

        # third-party cookies + cookie lifetime
        "network.cookie.cookieBehavior" = 5;               # 5 = reject all third-party + trackers
        "network.cookie.lifetimePolicy" = 2;               # 2 = sessions cookies
        "privacy.firstparty.isolate" = true;

        # Telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "beacon.enabled" = false;
        "browser.send_pings" = false;

        # WebGL / fonts / canvas — fingerprinting
        "webgl.disabled" = true;
        "javascript.options.wasm" = false;                  # can break some sites
        "layout.css.font-visibility.resistFingerprinting" = 1;

        # DNS over HTTPS — Cloudflare / Quad9 / NextDNS
        "network.trr.mode" = 3;                            # 3 = TRR only (DoH)

        # Other
        "privacy.clearOnShutdown.offlineApps" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = false;              # paranoia
      };

      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToDoNotTrack = true;
      SearchSuggestEnabled = false;

      profiles.default = {
        settings = {
          "privacy.clearOnShutdown.offlineApps" = true;
          "signon.rememberSignons" = false;
        };
      };

      ExtensionSettings = {
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };

        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };

        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          installation_mode = "force_installed";
        };

        "{55f61747-c3d3-4425-97f9-dfc19a0be23c}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/spoof-timezone/latest.xpi";
          installation_mode = "force_installed";
        };

        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
          installation_mode = "force_installed";
        };

        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          installation_mode = "force_installed";
        };

        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };

        "{2b71ab6f-cc0d-4ff8-b482-470f988d5c19}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/get-tamper-monkey/latest.xpi";
          installation_mode = "force_installed";
        };

        "CanvasBlocker@kkapsner.de" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/latest.xpi";
          installation_mode = "force_installed";
        };

        "{96ef5869-e3ba-4d21-b86e-21b163096400}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/font-fingerprint-defender/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
  };
}
