# Volatility3 MCP Server - Prerequisites Check (Windows)

Write-Host "=== Volatility3 MCP Server - Prerequisites Check (Windows) ===" -ForegroundColor Cyan
Write-Host "Current User: $env:USERNAME"
Write-Host "Current Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host ""

$errors = 0

# Check Python
Write-Host "Checking Python..." -NoNewline
try {
    $pythonVersion = python --version 2>&1
    if ($pythonVersion -match "Python (\d+\.\d+)") {
        $version = [version]$matches[1]
        if ($version -ge [version]"3.8") {
            Write-Host " OK - Python $version installed" -ForegroundColor Green
        } else {
            Write-Host " ERROR - Python $version is too old (need 3.8+)" -ForegroundColor Red
            $errors++
        }
    }
} catch {
    Write-Host " ERROR - Python not found" -ForegroundColor Red
    Write-Host "Please install Python 3.8+ from https://www.python.org/downloads/"
    $errors++
}

# Check Git
Write-Host "Checking Git..." -NoNewline
try {
    $gitVersion = git --version 2>&1
    if ($gitVersion -match "git version") {
        Write-Host " OK - Git installed" -ForegroundColor Green
    }
} catch {
    Write-Host " ERROR - Git not found" -ForegroundColor Red
    Write-Host "Please install Git from https://git-scm.com/download/win"
    $errors++
}

# Check pip
Write-Host "Checking pip..." -NoNewline
try {
    $pipVersion = python -m pip --version 2>&1
    if ($pipVersion -match "pip") {
        Write-Host " OK - pip installed" -ForegroundColor Green
    }
} catch {
    Write-Host " ERROR - pip not found" -ForegroundColor Red
    $errors++
}

if ($errors -eq 0) {
    Write-Host ""
    Write-Host "Prerequisites check complete!" -ForegroundColor Green
    exit 0
} else {
    Write-Host ""
    Write-Host "Please install missing prerequisites before continuing." -ForegroundColor Yellow
    exit 1
}