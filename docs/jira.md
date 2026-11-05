# Jira details

Read when falling back to the REST API, posting a comment, or creating tickets.

- If the Atlassian MCP connector is not responding (errors or timeouts), or can't do the job (e.g. uploading
  attachments), fall back to the Jira REST API (`https://showplacecabinetry.atlassian.net/rest/api/3/...`) with my
  personal token: `curl -u "$JIRA_EMAIL:$JIRA_API_TOKEN" ...`. Never print the token. After an MCP write times out,
  read the item back before retrying, because the write may have applied anyway.
- When posting a summary of changes as a Jira ticket comment on an ITHD- or EVOX-prefixed ticket, write it for the
  customer/reporter, not for a developer audience: no file paths, function/class names, commit hashes, or other
  implementation details. Close the comment with "This change is being QAd and will be promoted to production when
  it passes" rather than claiming the change is already tested or ready for release. Exception: if the change was
  already deployed to production in the same session, leave that closing line off. For tickets in any other
  project, write the summary developer-facing (implementation details, file references, etc. are fine).
- When creating Jira tickets, organize the work in three levels:
  - Epic = one main feature (for example, Profile Management).
  - Tasks = the main, testable parts of that feature (for example, the registration screen, the user registration
    approval screen, and the marketing tab with communication preferences). Each task must describe the expected
    behavior and what "done" looks like.
  - Subtasks = small, usually technical pieces needed to complete a task (for example, adding form validation,
    wiring up the registration API, saving the user's profile, adding database fields, handling save errors). They
    support the task's outcome and give developers a place to track implementation details.
- When I don't give you an assignee for a ticket, assign it to the person in the Administrator role under the
  space's access settings. If more than one person holds that role, ask me which one.
