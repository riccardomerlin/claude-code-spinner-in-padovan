# Claude Code Spinner Verbs - Padova Edition
# "Destrighete, nemo te magna!" - Nonno from Padova

#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRaw = if ($env:PADOVAN_VERBS_RAW) { $env:PADOVAN_VERBS_RAW } else { 'https://raw.githubusercontent.com/riccardomerlin/claude-code-spinner-in-padovan/master' }
$VerbsUrl = "$RepoRaw/spinner-verbs.json"
$SettingsDir = Join-Path $HOME '.claude'
$SettingsFile = Join-Path $SettingsDir 'settings.json'

function Write-Ok([string]$m)    { Write-Host $m -ForegroundColor Green }
function Write-Warn2([string]$m) { Write-Host $m -ForegroundColor Yellow }
function Write-Err2([string]$m)  { Write-Host $m -ForegroundColor Red }
function Write-Bold([string]$m)  { Write-Host $m -ForegroundColor Cyan }

Write-Bold 'Ciao beo! Scarico i verbi padovani...'

try {
    $verbsRaw = Invoke-RestMethod -Uri $VerbsUrl -UseBasicParsing
} catch {
    Write-Err2 "No go catà i verbi. Controla la rete, xe tuto a remengo."
    Write-Err2 $_.Exception.Message
    exit 1
}

# Invoke-RestMethod auto-parses JSON; re-serialize to validate shape
try {
    if ($verbsRaw -is [string]) {
        $verbsObj = $verbsRaw | ConvertFrom-Json -ErrorAction Stop
    } else {
        $verbsObj = $verbsRaw
    }
    if (-not $verbsObj.spinnerVerbs -or -not $verbsObj.spinnerVerbs.verbs) {
        throw "spinnerVerbs.verbs mancante"
    }
} catch {
    Write-Err2 "El JSON xe sbrindelà. Sbaglio nel file: $($_.Exception.Message)"
    exit 1
}

if (-not (Test-Path $SettingsDir)) {
    New-Item -ItemType Directory -Path $SettingsDir | Out-Null
}

function Write-SettingsJson($obj) {
    $json = $obj | ConvertTo-Json -Depth 100
    Set-Content -Path $SettingsFile -Value $json -Encoding UTF8
}

function Apply-Overwrite {
    Write-SettingsJson $verbsObj
    Write-Ok "Verbi piantài (overwrite). Destrighete a riaviare Claude Code."
}

function Apply-Merge {
    $existing = Get-Content -Raw -Path $SettingsFile | ConvertFrom-Json
    # Merge: set/replace spinnerVerbs, keep everything else
    if ($existing.PSObject.Properties.Name -contains 'spinnerVerbs') {
        $existing.spinnerVerbs = $verbsObj.spinnerVerbs
    } else {
        $existing | Add-Member -NotePropertyName 'spinnerVerbs' -NotePropertyValue $verbsObj.spinnerVerbs
    }
    Write-SettingsJson $existing
    Write-Ok "Verbi ingrumài (merge). Destrighete a riaviare Claude Code."
}

if (Test-Path $SettingsFile) {
    $ts = Get-Date -Format 'yyyyMMddHHmmss'
    $backup = "$SettingsFile.bak.$ts"
    Copy-Item -Path $SettingsFile -Destination $backup
    Write-Warn2 "Backup salvà: $backup"

    Write-Bold 'Settings esistenti catài. Cossa femo?'
    Write-Host "  [m] merge     - tegno el resto, sovrascrivo solo spinnerVerbs"
    Write-Host "  [o] overwrite - sbrego tuto e meto sti verbi"
    Write-Host "  [c] cancel    - no toco gnente"
    $choice = Read-Host 'Scegli [m/o/c]'
    switch ($choice.ToLower()) {
        'm' { Apply-Merge }
        'o' { Apply-Overwrite }
        'c' { Write-Warn2 'Anulà. Gnente canbià.'; exit 0 }
        default { Write-Err2 'Risposta no valida. Tajo la corda.'; exit 1 }
    }
} else {
    Apply-Overwrite
}

Write-Bold 'Fato! Desso Claude Code el parla padovan. Daghene!'
