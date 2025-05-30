function jira-sprint --description "Run jira sprint commands with predefined states"
    set -l valid_states active future
    
    if test (count $argv) -eq 0
        echo "Usage: jira-sprint --state=value"
        echo "Available states: $valid_states"
        return 1
    end
    
    for arg in $argv
        if not string match -q -- "--*=*" $arg
            echo "Error: Invalid format '$arg'. Use --state=value"
            return 1
        end
        
        set -l key_value (string split -- "=" $arg)
        set -l key (string replace -- "--" "" $key_value[1])
        set -l value $key_value[2]
        
        if test "$key" != "state"
            echo "Error: Invalid key '$key'. Only 'state' is supported"
            return 1
        end
        
        if not contains $value $valid_states
            echo "Error: Invalid state value '$value'"
            echo "Valid states: $valid_states"
            return 1
        end
        
        echo "Running: jira sprint list --state $value"
        jira sprint list --state $value
    end
end