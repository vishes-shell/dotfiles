fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path ~/.local/bin

yes | fish_config theme save "Catppuccin Latte"

starship init fish | source

for file in ~/.{exports,aliases,functions,extra}
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
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

if status is-inteactive
  atuin init fish | source
end
