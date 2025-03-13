# overlays/default.nix
inputs: final: prev:
# Apply custom overlays here
# inputs.siovim.overlays.default final prev //
{
  # Your additional custom overlays here
  # example = prev.example.overrideAttrs (old: { ... });
  # neovim = (final.neovim-nightly-overlay.overlays.default final prev).neovim;
  # wezterm = final.wezterm-nightly.packages.${prev.system}.default;
}
