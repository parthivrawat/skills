#requires -Version 5.1
<#
.SYNOPSIS
    Runs the full quality gate for the skill library.
.DESCRIPTION
    Performs structural validation and additional quality checks on every
    skill and its platform adapters.
#>

[CmdletBinding()]
param (
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$allGood = $true

# Run the structural validator first.
$validatePath = Join-Path (Join-Path $Root "scripts") "validate.ps1"
try {
    & $validatePath -Root $Root
} catch {
    Write-Host "[ERROR] validate.ps1 reported failures." -ForegroundColor Red
    $allGood = $false
}

# Check every skill package.
$skillDir = Join-Path $Root "skills"
if (Test-Path $skillDir) {
    $skillFiles = Get-ChildItem $skillDir -Filter "SKILL.md" -Recurse -File
    foreach ($file in $skillFiles) {
        $skillName = Split-Path -Leaf $file.DirectoryName
        Write-Host "Quality check: $skillName" -ForegroundColor Cyan

        $dir = $file.DirectoryName
        $content = Get-Content $file.FullName -Raw
        $body = [regex]::Replace($content, "(?s)^---\r?\n.*?\r?\n---\r?\n", "")

        # Required package files
        $readme = Join-Path $dir "README.md"
        $tests = Join-Path $dir "tests"
        $examples = Join-Path $dir "examples"

        if (!(Test-Path $readme)) {
            Write-Host "  [ERROR] Missing README.md" -ForegroundColor Red
            $allGood = $false
        }
        if (!(Test-Path $tests)) {
            Write-Host "  [ERROR] Missing tests/ directory" -ForegroundColor Red
            $allGood = $false
        }
        if (!(Test-Path $examples)) {
            Write-Host "  [ERROR] Missing examples/ directory" -ForegroundColor Red
            $allGood = $false
        }

        # At least two examples
        $exampleCount = ([regex]::Matches($body, "(?m)^### Example")).Count
        if ($exampleCount -lt 2) {
            Write-Host "  [ERROR] Expected at least 2 examples, found $exampleCount" -ForegroundColor Red
            $allGood = $false
        }

        # No unresolved placeholders or TBD markers
        if ($body -match 'TBD|<[^>]+>') {
            Write-Host "  [ERROR] Contains unresolved placeholders or TBD markers" -ForegroundColor Red
            $allGood = $false
        }

        # Populated change history
        if ($body -notmatch '## Change History\s*\r?\n\s*\r?\n### ') {
            Write-Host "  [ERROR] Change History is empty" -ForegroundColor Red
            $allGood = $false
        }
    }
}

# Check every adapter package.
$adapterDir = Join-Path $Root "adapters"
if (Test-Path $adapterDir) {
    $platforms = Get-ChildItem $adapterDir -Directory
    foreach ($platform in $platforms) {
        $skills = Get-ChildItem $platform.FullName -Directory
        foreach ($skill in $skills) {
            $adapter = $skill.FullName
            $adapterDoc = Join-Path $adapter "ADAPTER.md"
            $skillFiles = Get-ChildItem $adapter -File | Where-Object { $_.Name -match '^(SKILL\.md|tool\.json)$' }

            if (!(Test-Path $adapterDoc)) {
                Write-Host "[ERROR] Adapter for $($platform.Name)/$($skill.Name) missing ADAPTER.md" -ForegroundColor Red
                $allGood = $false
            }
            if ($skillFiles.Count -eq 0) {
                Write-Host "[ERROR] Adapter for $($platform.Name)/$($skill.Name) missing SKILL.md or tool.json" -ForegroundColor Red
                $allGood = $false
            }
        }
    }
}

if ($allGood) {
    Write-Host "Quality gate passed." -ForegroundColor Green
    exit 0
} else {
    throw "Quality gate failed."
}
