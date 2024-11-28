{
  pkgs,
  lib,
  # config,
  # inputs,
  ...
}:

{
  cachix.enable = false;

  env.APPLE_DEVELOPMENT_TEAM = "W5JUHW3QRX";
  # https://devenv.sh/packages/
  packages =
    with pkgs;
    [
      pkg-config
      gobject-introspection
      cargo-tauri

      # build inputs
      at-spi2-atk
      atkmm
      cairo
      gdk-pixbuf
      glib
      gtk3
      harfbuzz
      librsvg
      libsoup_3
      pango
      openssl
      rustup
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      webkitgtk_4_1
      android-studio
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
      libiconv
      darwin.apple_sdk.Libsystem
      darwin.apple_sdk.frameworks.AppKit
      darwin.apple_sdk.frameworks.Cocoa
      darwin.apple_sdk.frameworks.CoreServices
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
      darwin.apple_sdk.frameworks.WebKit
      darwin.apple_sdk.frameworks.Foundation
      darwin.apple_sdk.frameworks.SwiftUI
      darwin.apple_sdk.frameworks.UIFoundation
      darwin.libobjc
      # llvmPackages.libcxxStdenv
      # llvmPackages.libcxxClang
    ];
  stdenv = pkgs.stdenvNoCC;
  # cargo build --package tauri-app --manifest-path /Users/x/Projects/tauri-app/src-tauri/Cargo.toml --target aarch64-apple-ios-sim --features tauri/rustls-tls --lib --no-default-features

  # https://devenv.sh/languages/
  languages = {
    deno.enable = true;
    javascript = {
      enable = true;
      npm.enable = true;
    };
    rust = {
      enable = true;
      channel = "stable";
      targets =
        [
          "aarch64-linux-android"
          "armv7-linux-androideabi"
          "i686-linux-android"
          "x86_64-linux-android"
        ]
        ++ lib.optionals pkgs.stdenv.isDarwin [
          "aarch64-apple-darwin"
          "aarch64-apple-ios"
          "aarch64-apple-ios-sim"
          "x86_64-apple-ios"
        ];
      components = [
        "rustc"
        "cargo"
        "clippy"
        "rustfmt"
        "rust-analyzer"
      ];

      # mold.enable = true;
    };
  };

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  # scripts.hello.exec = ''
  #   echo hello from $GREET
  # '';

  enterShell =
    if pkgs.stdenv.isLinux then
      # sh
      ''
        # for linux, probably different on nix
        # TODO: change this to reference nix install path
        export JAVA_HOME=/opt/android-studio/jbr
        export ANDROID_HOME="$HOME/Android/Sdk"
        export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
      ''
    else if pkgs.stdenv.isDarwin then
      # sh
      ''
        export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
        export ANDROID_HOME="$HOME/Library/Android/sdk"
        export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"

      ''
    else
      ''
        echo "Unsupported OS"
      '';
  # export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
  # # does not work
  # export LDFLAGS="-isysroot $SDKROOT -F${pkgs.darwin.apple_sdk.frameworks.WebKit}/Library/Frameworks $LDFLAGS"
  # export CFLAGS="-isysroot $SDKROOT -F${pkgs.darwin.apple_sdk.frameworks.WebKit}/Library/Frameworks $CFLAGS"

  # https://devenv.sh/tests/
  # enterTest = ''
  #   echo "Running tests"
  #   git --version | grep --color=auto "${pkgs.git.version}"
  # '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
