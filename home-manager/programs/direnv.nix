{ ... }:
{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.stdlib = ''
    # $HOME/.config/direnv/direnvrc
    : ''${XDG_CACHE_HOME:=$HOME/.cache}
    declare -A direnv_layout_dirs
    direnv_layout_dir() {
        echo "''${direnv_layout_dirs[$PWD]:=$(
            echo -n "$XDG_CACHE_HOME"/direnv/layouts/
            echo -n "$PWD" | shasum | cut -d ' ' -f 1
        )}"
    }
  '';

  programs.zsh.shellAliases.flakify = ''{
    if [ ! -e flake.nix ]; then
       nix flake new -t github:nix-community/nix-direnv .
    elif [ ! -e .envrc ]; then
       echo "use flake" > .envrc
       direnv allow
    fi
  }'';
}
