#requires -Version 5.1
<#
.SYNOPSIS
    Validates all SKILL.md files in the skills/ directory.
.DESCRIPTION
    Performs a lightweight structural validation: YAML frontmatter keys,
    kebab-case names, semantic versions, and required Markdown sections.
#>

[CmdletBinding()]
param (
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$requiredFrontmatter = @("name", "version", "description", "author", "license", "status", "tags")
$requiredSections = @(
    "Purpose",
    "Scope",
    "When to Use",
    "When Not to Use",
    "Preconditions",
    "Inputs",
    "Context",
    "Tools and Resources",
    "Procedure",
    "Decision Rules",
    "Output Contract",
    "Error Handling",
    "Safety and Security",
    "Quality Requirements",
    "Examples",
    "Validation",
    "Dependencies",
    "Versioning",
    "Change History"
)

$skillDir = Join-Path $Root "skills"
$allGood = $true
$seenNames = @{}

function Get-Frontmatter {
    param([string]$Path)
    $raw = Get-Content $Path -Raw
    if ($raw -notmatch "(?s)^---\r?\n(.*?)\r?\n---\r?\n") { return $null }
    $block = $Matches[1]
    $obj = @{}
    foreach ($line in $block -split "`r?`n") {
        if ($line -match "^(\w+):\s*(.*)$") {
            $obj[$matches[1].Trim()] = $matches[2].Trim()
        }
    }
    return $obj
}

if (!(Test-Path $skillDir)) {
    throw "skills/ directory not found at $skillDir"
}

$skillFiles = Get-ChildItem $skillDir -Filter "SKILL.md" -Recurse -File

if ($skillFiles.Count -eq 0) {
    Write-Host "No SKILL.md files found under $skillDir yet. Nothing to validate."
    exit 0
}

foreach ($file in $skillFiles) {
    Write-Host "Validating: $($file.FullName)" -ForegroundColor Cyan
    $fm = Get-Frontmatter -Path $file.FullName
    if (-not $fm) {
        Write-Host "  [ERROR] Missing or malformed YAML frontmatter" -ForegroundColor Red
        $allGood = $false
        continue
    }

    foreach ($key in $requiredFrontmatter) {
        if (-not $fm.ContainsKey($key) -or [string]::IsNullOrWhiteSpace($fm[$key])) {
            Write-Host "  [ERROR] Missing required frontmatter key: $key" -ForegroundColor Red
            $allGood = $false
        }
    }

    if ($fm.name) {
        if ($fm.name -notmatch "^[a-z0-9]+(-[a-z0-9]+)*$") {
            Write-Host "  [ERROR] Name '$($fm.name)' does not match kebab-case" -ForegroundColor Red
            $allGood = $false
        }
        if ($seenNames.ContainsKey($fm.name)) {
            Write-Host "  [ERROR] Duplicate skill name: $($fm.name)" -ForegroundColor Red
            $allGood = $false
        } else {
            $seenNames[$fm.name] = $true
        }
    }

    if ($fm.version -and $fm.version -notmatch "^\d+\.\d+\.\d+$") {
        Write-Host "  [ERROR] Version '$($fm.version)' is not in MAJOR.MINOR.PATCH format" -ForegroundColor Red
        $allGood = $false
    }

    $content = Get-Content $file.FullName -Raw
    foreach ($section in $requiredSections) {
        $pattern = "(?m)^##\s+" + [regex]::Escape($section) + "(\s|$)"
        if ($content -notmatch $pattern) {
            Write-Host "  [ERROR] Missing required section: ## $section" -ForegroundColor Red
            $allGood = $false
        }
    }
}

if ($allGood) {
    Write-Host "All skill files passed validation." -ForegroundColor Green
    exit 0
} else {
    throw "Validation failed."
}
