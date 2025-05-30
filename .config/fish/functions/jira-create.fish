function jira-create --description "Create jira issue with predefined options"
    set -l valid_types Задача Техдолг
    set -l valid_labels back front engineering
    set -l valid_components authentication block-lesson client-course code-grader content-file continious-delivery course course-package development-tools diploma django-admin documentation expert-sender external-course external-vendor gitlab-manager homework homework-balancer homework-processing learning-process infrastructure lerna lesson-grades longread loyalty-program mindbox refactoring-common study-group passport program-access teachers-management teachers-statistics topic user-data user-feedback video videolesson
    set -l valid_assignees "Никита Ангелов" "Алексей Шалынин"

    if test (count $argv) -eq 0
        echo "Usage: jira-create <type> [--label|-l=value1,value2] [--component|-c=value] [--sprint|-s=value] [--assignee|-a=value]"
        echo "Available types: $valid_types"
        echo "Available labels: $valid_labels"
        echo "Available components: $valid_components"
        echo "Available assignees: $valid_assignees"
        return 1
    end

    set -l issue_type $argv[1]
    if not contains $issue_type $valid_types
        echo "Error: Invalid type '$issue_type'"
        echo "Available types: $valid_types"
        return 1
    end

    set -l labels_list
    set -l components_list
    set -l sprint_value ""
    set -l assignee_value "Алексей Шалынин"

    for arg in $argv[2..]
        if not string match -q -- "--*=*" $arg; and not string match -q -- "-*=*" $arg
            echo "Error: Invalid format '$arg'. Use --key=value or -k=value"
            return 1
        end

        set -l key_value (string split -- "=" $arg)
        set -l key (string replace -r -- "^--?(.+)" '$1' $key_value[1])
        set -l value $key_value[2]

        switch $key
            case label l
                set -l label_list (string split -- "," $value)
                for label in $label_list
                    if not contains $label $valid_labels
                        echo "Error: Invalid label '$label'"
                        echo "Valid labels: $valid_labels"
                        return 1
                    end
                    set -a labels_list $label
                end
            case sprint s
                set sprint_value $value
            case assignee a
                if not contains $value $valid_assignees
                    echo "Error: Invalid assignee '$value'"
                    echo "Valid assignees: $valid_assignees"
                    return 1
                end
                set assignee_value $value
            case component c
                set -l component_list (string split -- "," $value)
                for component in $component_list
                    if not contains $component $valid_components
                        echo "Error: Invalid component '$component'"
                        echo "Valid components: $valid_components"
                        return 1
                    end
                    set -a components_list $component
                end
            case '*'
                echo "Error: Invalid key '$key'"
                echo "Valid keys: label (l), component (c), sprint (s), assignee (a)"
                return 1
        end
    end

    set -l cmd jira issue create --type $issue_type

    if test (count $labels_list) -gt 0
        set -l combined_labels (string join "," $labels_list)
        set cmd $cmd --label $combined_labels
    end

    if test (count $components_list) -gt 0
        set -l combined_components (string join "," $components_list)
        set cmd $cmd --component $combined_components
    end

    if test -n "$sprint_value"
        set cmd $cmd --custom=sprint=$sprint_value
    end

    set cmd $cmd --assignee "\"$assignee_value\""

    set cmd $cmd --summary "\"$(cat ~/tmp/jira/issue-summary.txt)\""
    set cmd $cmd --template ~/tmp/jira/issue-description.md
    set cmd $cmd --no-input

    echo "Running: $cmd"
    eval $cmd
end
