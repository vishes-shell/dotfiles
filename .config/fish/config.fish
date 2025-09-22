fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path ~/.rye/env
fish_add_path ~/.rye/shims
fish_add_path ~/.cargo/bin
fish_add_path /usr/local/opt/postgresql@11/bin
fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
fish_add_path ~/.opencode/bin
fish_add_path ~/.bun/bin
fish_add_path ~/.local/gettext-0.23.1/bin

yes | fish_config theme save "Catppuccin Latte"

if status is-interactive
    starship init fish | source

    set -x ATUIN_NOBIND true
    atuin init fish | source
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
end

for file in ~/.{exports,aliases,functions,extra}
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
end

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

set -U fish_greeting "🐟"

fish_vi_key_bindings

set LS_COLORS (vivid generate catppuccin-latte)
set RIPGREP_CONFIG_PATH ~/.config/ripgrep/.rg

zoxide init fish | source
