$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$distPath = Join-Path $projectRoot "dist"
$zipPath = Join-Path $distPath "HiddenDice.zip"
$extensionPath = Join-Path $distPath "HiddenDice.ext"

New-Item -ItemType Directory -Path $distPath -Force | Out-Null

if (Test-Path -LiteralPath $zipPath) {
	Remove-Item -LiteralPath $zipPath
}
if (Test-Path -LiteralPath $extensionPath) {
	Remove-Item -LiteralPath $extensionPath
}

$packageItems = @(
	(Join-Path $projectRoot "extension.xml"),
	(Join-Path $projectRoot "campaign"),
	(Join-Path $projectRoot "scripts"),
	(Join-Path $projectRoot "strings"),
	(Join-Path $projectRoot "README.md"),
	(Join-Path $projectRoot "LICENSE")
)

Compress-Archive -Path $packageItems -DestinationPath $zipPath -CompressionLevel Optimal
Move-Item -LiteralPath $zipPath -Destination $extensionPath

Write-Output $extensionPath
