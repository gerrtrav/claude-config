# Show a Windows toast notification when Claude Code finishes a turn (native Windows).
# Windows port of ~/.claude/hooks/notify-windows.sh from WSL (Ubuntu-24.04).
$ErrorActionPreference = 'SilentlyContinue'

$project = ''
try {
    $payload = [Console]::In.ReadToEnd() | ConvertFrom-Json
    if ($payload.cwd) { $project = Split-Path -Leaf $payload.cwd }
} catch { }

$msg = 'Claude finished'
if ($project) { $msg = "Claude finished in $project" }

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
$xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
$t = $xml.GetElementsByTagName('text')
$t.Item(0).AppendChild($xml.CreateTextNode('Claude Code')) | Out-Null
$t.Item(1).AppendChild($xml.CreateTextNode($msg)) | Out-Null
$appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show([Windows.UI.Notifications.ToastNotification]::new($xml))
