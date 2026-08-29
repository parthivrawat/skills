#requires -Version 5.1
<#
.SYNOPSIS
    Validates all SKILL.md files in the skills/ directory.
.DESCRIPTION
    Performs a structural validation: YAML frontmatter (against the schema
    in schemas/skill-frontmatter.schema.json), kebab-case names, semantic
    versions, status values, and required Markdown sections.
#>

[CmdletBinding()]
param (
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

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
    $lines = $Matches[1] -split "`r?`n"
    $obj = @{
        __raw = $Matches[1]
    }
    $i = 0
    while ($i -lt $lines.Count) {
        $line = $lines[$i]
        if ($line -match "^(\w+):\s*(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            if ($value -eq "") {
                # Check for a YAML list on following lines
                $list = @()
                $j = $i + 1
                while ($j -lt $lines.Count -and $lines[$j] -match "^\s*-\s+(.*)$") {
                    $list += $matches[1].Trim()
                    $j++
                }
                if ($list.Count -gt 0) {
                    $obj[$key] = $list
                    $i = $j - 1
                } else {
                    $obj[$key] = ""
                }
            } else {
                $obj[$key] = $value
            }
        }
        $i++
    }
    return $obj
}

# Load the frontmatter schema for required fields and constraints.
$schemaPath = Join-Path (Join-Path $Root "schemas") "skill-frontmatter.schema.json"
$schema = $null
if (Test-Path $schemaPath) {
    $schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
}

if ($schema -and $schema.required) {
    $requiredFrontmatter = $schema.required
} else {
    $requiredFrontmatter = @("name", "version", "description", "author", "license", "status", "tags")
}

if ($schema -and $schema.properties.name.pattern) {
    $namePattern = $schema.properties.name.pattern
} else {
    $namePattern = "^[a-z0-9]+(-[a-z0-9]+)*$"
}

if ($schema -and $schema.properties.version.pattern) {
    $versionPattern = $schema.properties.version.pattern
} else {
    $versionPattern = "^\d+\.\d+\.\d+$"
}

if ($schema -and $schema.properties.status.enum) {
    $statusEnum = $schema.properties.status.enum
} else {
    $statusEnum = @("stable", "beta", "alpha", "experimental", "deprecated")
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
        if (-not $fm.ContainsKey($key)) {
            Write-Host "  [ERROR] Missing required frontmatter key: $key" -ForegroundColor Red
            $allGood = $false
        } elseif ($fm[$key] -is [array]) {
            if ($fm[$key].Count -eq 0) {
                Write-Host "  [ERROR] Required frontmatter list is empty: $key" -ForegroundColor Red
                $allGood = $false
            }
        } elseif ([string]::IsNullOrWhiteSpace($fm[$key])) {
            Write-Host "  [ERROR] Required frontmatter value is empty: $key" -ForegroundColor Red
            $allGood = $false
        }
    }

    if ($fm.name) {
        if ($fm.name -cnotmatch $namePattern) {
            Write-Host "  [ERROR] Name '$($fm.name)' does not match the required pattern '$namePattern'" -ForegroundColor Red
            $allGood = $false
        }
        if ($seenNames.ContainsKey($fm.name)) {
            Write-Host "  [ERROR] Duplicate skill name: $($fm.name)" -ForegroundColor Red
            $allGood = $false
        } else {
            $seenNames[$fm.name] = $true
        }
    }

    if ($fm.version -and $fm.version -notmatch $versionPattern) {
        Write-Host "  [ERROR] Version '$($fm.version)' is not in MAJOR.MINOR.PATCH format" -ForegroundColor Red
        $allGood = $false
    }

    if ($fm.status -and $statusEnum -notcontains $fm.status) {
        Write-Host "  [ERROR] Status '$($fm.status)' is not one of: $($statusEnum -join ', ')" -ForegroundColor Red
        $allGood = $false
    }

    if ($fm.tags -is [array]) {
        $emptyTags = $fm.tags | Where-Object { [string]::IsNullOrWhiteSpace($_) }
        if ($emptyTags) {
            Write-Host "  [ERROR] Tags contains empty entries" -ForegroundColor Red
            $allGood = $false
        }
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
