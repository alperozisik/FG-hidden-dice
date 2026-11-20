$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$distPath = Join-Path $projectRoot "dist"
$zipPath = Join-Path $distPath "HiddenDice.zip"
$extensionPath = Join-Path $distPath "HiddenDice.ext"
$stagingPath = Join-Path $distPath ".package"
$allowedExtensions = @(".xml", ".jpg", ".jpeg", ".png", ".lua", ".txt", ".md", ".ttf", ".otf", ".fgf")

New-Item -ItemType Directory -Path $distPath -Force | Out-Null

try {
	foreach ($path in @($zipPath, $extensionPath, $stagingPath)) {
		if (Test-Path -LiteralPath $path) {
			Remove-Item -LiteralPath $path -Recurse -Force
		}
	}

	New-Item -ItemType Directory -Path $stagingPath | Out-Null

	Copy-Item -LiteralPath (Join-Path $projectRoot "extension.xml") -Destination $stagingPath
	Copy-Item -LiteralPath (Join-Path $projectRoot "campaign") -Destination $stagingPath -Recurse
	Copy-Item -LiteralPath (Join-Path $projectRoot "scripts") -Destination $stagingPath -Recurse
	Copy-Item -LiteralPath (Join-Path $projectRoot "strings") -Destination $stagingPath -Recurse
	Copy-Item -LiteralPath (Join-Path $projectRoot "README.md") -Destination $stagingPath
	Copy-Item -LiteralPath (Join-Path $projectRoot "LICENSE") -Destination (Join-Path $stagingPath "LICENSE.txt")

	$invalidFiles = Get-ChildItem -LiteralPath $stagingPath -Recurse -File | Where-Object {
		$allowedExtensions -notcontains $_.Extension.ToLowerInvariant()
	}
	if ($invalidFiles) {
		$invalidNames = $invalidFiles.FullName -join [Environment]::NewLine
		throw "Package contains file types not allowed by the Fantasy Grounds Forge whitelist:$([Environment]::NewLine)$invalidNames"
	}

	Compress-Archive -Path (Join-Path $stagingPath "*") -DestinationPath $zipPath -CompressionLevel Optimal
	Move-Item -LiteralPath $zipPath -Destination $extensionPath

	Add-Type -AssemblyName System.IO.Compression.FileSystem
	$archive = [System.IO.Compression.ZipFile]::OpenRead($extensionPath)
	try {
		$fileEntries = $archive.Entries | Where-Object { -not [string]::IsNullOrEmpty($_.Name) }
		$invalidEntries = $fileEntries | Where-Object {
			$allowedExtensions -notcontains [System.IO.Path]::GetExtension($_.Name).ToLowerInvariant()
		}
		if ($invalidEntries) {
			$invalidNames = $invalidEntries.FullName -join [Environment]::NewLine
			throw "Built extension contains file types not allowed by the Fantasy Grounds Forge whitelist:$([Environment]::NewLine)$invalidNames"
		}

		$entryNames = $fileEntries.FullName
		if ($entryNames -notcontains "LICENSE.txt") {
			throw "Built extension is missing LICENSE.txt."
		}
		if ($entryNames -contains "LICENSE") {
			throw "Built extension contains the unsupported extensionless LICENSE file."
		}
	}
	finally {
		$archive.Dispose()
	}

	$hash = (Get-FileHash -LiteralPath $extensionPath -Algorithm SHA256).Hash
	Write-Output $extensionPath
	Write-Output "Forge whitelist validation passed."
	Write-Output "SHA256: $hash"
}
finally {
	if (Test-Path -LiteralPath $stagingPath) {
		Remove-Item -LiteralPath $stagingPath -Recurse -Force
	}
}
