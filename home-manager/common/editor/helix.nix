{ ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        true-color = true;
        line-number = "relative";
        auto-save = true;
        color-modes = true;
        soft-wrap.enable = true;
      };
      keys.normal.esc = [
        "collapse_selection"
        "keep_primary_selection"
      ];
    };
  };
}
