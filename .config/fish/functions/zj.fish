function zj --description "Start zellij (nvim + claude)"
    set -l location $argv[1]

    # Change to location if provided
    if test -n "$location"
        cd $location
    end

    # Activate venv if exists
    if test -f .venv/bin/activate.fish
        source .venv/bin/activate.fish
    end

    # Start zellij with default layout
    zellij
end
