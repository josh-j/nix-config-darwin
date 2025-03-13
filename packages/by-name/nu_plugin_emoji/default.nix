{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  name = "nu_plugin_emoji";
  version = "0.10.0-unstable-2024-12-25";
  src = fetchFromGitHub {
    owner = "fdncred";
    repo = "nu_plugin_emoji";
    rev = "447e6a02cd98286702735c33e75771086db80bb0";
    hash = "sha256-7dxWvwktuIBJVWgg6mDA/a3qHp+MlBx7Q/HijLR7FUg=";
  };
  cargoHash = "sha256-PaUpG4U2cLp0yz6/cdkiq99WlrCgcq8WWPgYC7n7o0E=";
  meta.mainProgram = "nu_plugin_emoji";
}
