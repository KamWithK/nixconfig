{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    nativeMessagingHosts = [ pkgs.vdhcoapp ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      PasswordManagerEnabled = false;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never";
      SearchBar = "unified";

      NoDefaultBookmarks = true;
      OfferToSaveLoginsDefault = false;
      OfferToSaveLogins = false;
      TranslateEnabled = true;

      HttpsOnlyMode = "force_enabled";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Shortcut = false;
      };

      Extensions.Install = [
        "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/ublock_origin/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/videospeed/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/video_downloadhelper/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/privacy_badger/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi"
      ];

      EncryptedMediaExtensions.Enabled = true;

      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "browser.topsites.contile.enabled" = {
          Value = false;
          Status = "locked";
        };
      };
    };

    profiles."kamwithk" = {
      isDefault = true;

      settings = {
        "browser.search.defaultenginename" = "Brave";
        "browser.search.order.1" = "Brave";

        "signon.rememberSignons" = false;
        "browser.aboutConfig.showWarning" = false;
      };

      search = {
        force = true;
        default = "Brave";
        engines."Brave".urls = [
          {
            template = "https://search.brave.com/search?";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        order = [
          "Brave"
          "Google"
        ];
      };
    };
  };

  stylix.targets.firefox.profileNames = [ "kamwithk" ];
}
