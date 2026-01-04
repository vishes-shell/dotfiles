function jp
    set key $argv[1]
    jira issue move $key "To Progress"
end
