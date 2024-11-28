# Few Word Do Trick 

A fun game to play with your friends. Big words bad, small words good.

Gameplay (2-∞ players):
- First player gets the phone and is given a word. Active player may not reveal the word to other players.
- Active player may describe the word any way they like but may only use single-syllable words. 
- Other players guess the word. A correct guess means the team scores a point and the next player in rotation goes.
- Rule violations or cheating (make up your own rules for cheating) will cost one point for each violation.


- Example 1:
  - Player 1 receives the word "recess"
  - Player 1 says "Kids go out and play at school lunch"
  - Another player guesses "see-saw", Player 1 does not respond
  - Another player guesses "recess", Player 1 exclaims "Yes!", next player gets the phone and draws another word

- Example 2:
  - Player 1 receives the word "recess"
  - Player 1 says "Kids go outside and play at school lunch"
  - Oops, "outside" is two syllables, dock 1 point from the overall score

## Development Setup 🧺

### 1. Basic Dependencies 🍍
1. Install `nix` ❄️. It is used to fetch the dependencies reproducibly. [Determinate Systems installer](https://github.com/determinateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer) is recommended for install.
2. Install `devenv`. `devenv` uses `nix` to manage dependencies, since managing `nix` is cumbersome. It basically adds superpowers to `nix`.
3. Install `direnv`, which is used to automatically load the the development environment.
4. Run `direnv allow`. It will now automatically load the development environment using `devenv`.

Steps 2 and 3 can be accomplished quickly by running:
```sh
nix shell nixpkgs#direnv nixpkgs#devenv
```
^ which drops you into a shell with `direnv` and `devenv` installed, temporarily. You will have to figure out how you want to install `direnv` and `devenv` more permanently. I recommend [Home Manager](https://github.com/nix-community/home-manager).


### 2. IOS Dependencies 🍎

Unfortunately, installing ios dependencies is less automatic and more involved/flaky.
1. Install XCode: `xcode-select --install`
   - you may also want to run `softwareupdate --install --all` to install the latest updates.
2. Install IOS SDK dependencies: `xcodebuild -importPlatform iOS`

### 3. Android Dependencies 🍏

Again, unfortunately, installing android dependencies is less automatic and more involved/flaky.
1. Install [Android Studio](https://developer.android.com/studio), I believe this is only required for Mac, the devenv shell already installs it on Linux. 
2. Use the SDK Manager in Android Studio to install the following:
   - Android SDK Platform
   - Android SDK Platform-Tools
   - NDK (Side by side)
   - Android SDK Build-Tools
   - Android SDK Command-line Tools

## Recommended IDE Setup

### NVIM

Make sure you have the TypeScript, Svelte and Rust LSP configs setup.

Running `:LspInfo` should return something like:

```
LSP configs active in this session (globally) ~
- Configured servers: rust_analyzer, svelte, ts_ls
```

### VS Code

[VS Code](https://code.visualstudio.com/) + [Svelte](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode) + [Tauri](https://marketplace.visualstudio.com/items?itemName=tauri-apps.tauri-vscode) + [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer).
