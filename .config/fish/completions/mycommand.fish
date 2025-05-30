complete -c mycommand -f -l env -a "dev staging prod" --description "Environment"
complete -c mycommand -f -l service -a "api web worker" --description "Service type"
complete -c mycommand -f -l version --description "Version number"
complete -c mycommand -f -l mode -a "fast slow debug" --description "Execution mode"