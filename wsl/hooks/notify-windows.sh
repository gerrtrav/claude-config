#!/usr/bin/env bash
# Show a Windows toast notification when Claude Code finishes a turn (WSL2).
project=$(python3 -c 'import json,sys,os; print(os.path.basename(json.load(sys.stdin).get("cwd","")))' 2>/dev/null)
msg="Claude finished${project:+ in $project}"
msg=${msg//\'/\'\'}
/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NonInteractive -Command "
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
\$xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
\$t = \$xml.GetElementsByTagName('text')
\$t.Item(0).AppendChild(\$xml.CreateTextNode('Claude Code')) | Out-Null
\$t.Item(1).AppendChild(\$xml.CreateTextNode('$msg')) | Out-Null
\$appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(\$appId).Show([Windows.UI.Notifications.ToastNotification]::new(\$xml))
"
