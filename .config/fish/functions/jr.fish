function jr
    set key $argv[1]
    jira issue move $key "to review"
end
