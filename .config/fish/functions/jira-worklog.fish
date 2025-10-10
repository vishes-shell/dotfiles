function jira-worklog
    set key $argv[1]
    set estimate $argv[2]
    jira issue worklog add $key $estimate --no-input
end
