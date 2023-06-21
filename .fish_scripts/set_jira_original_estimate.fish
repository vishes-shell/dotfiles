#!/usr/bin/env fish

# Jira credentials
set jiraUrl $JIRA_API_URL
set apiToken $JIRA_API_TOKEN

# Validate the number of arguments
if test (count $argv) -ne 2
    echo "Usage: ./set_original_estimate.fish <issueKey> <originalEstimate>"
    exit 1
end

# Extract the arguments
set issueKey $argv[1]
set originalEstimate $argv[2]

# Construct the REST API endpoint
set apiUrl "$jiraUrl/rest/api/2/issue/$issueKey"

# Prepare the JSON payload for the request
set payload "{\"fields\":{\"timetracking\":{\"originalEstimate\":\"$originalEstimate\"}}}"

# Make the API request
curl -H "Authorization: Bearer $apiToken" -X PUT -H "Content-Type: application/json" -d "$payload" $apiUrl
