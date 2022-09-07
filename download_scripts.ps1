# Download Commands
$repoURL = 'https://raw.githubusercontent.com/bseltz-cohesity/scripts/master/powershell'
$scriptName = 'registerGenericNasList'
(Invoke-WebRequest -UseBasicParsing -Uri "$repoUrl/$scriptName/$scriptName.ps1").content | Out-File "$scriptName.ps1"; (Get-Content "$scriptName.ps1") | Set-Content "$scriptName.ps1"

$scriptName = 'protectGenericNas'
(Invoke-WebRequest -UseBasicParsing -Uri "$repoUrl/$scriptName/$scriptName.ps1").content | Out-File "$scriptName.ps1"; (Get-Content "$scriptName.ps1") | Set-Content "$scriptName.ps1"

$scriptName = 'backupNow'
(Invoke-WebRequest -UseBasicParsing -Uri "$repoUrl/$scriptName/$scriptName.ps1").content | Out-File "$scriptName.ps1"; (Get-Content "$scriptName.ps1") | Set-Content "$scriptName.ps1"

$scriptName = 'protectVM'
(Invoke-WebRequest -UseBasicParsing -Uri "$repoUrl/$scriptName/$scriptName.ps1").content | Out-File "$scriptName.ps1"; (Get-Content "$scriptName.ps1") | Set-Content "$scriptName.ps1"

(Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/bseltz-cohesity/scripts/master/powershell/deployWindowsAgent/deployWindowsAgent.ps1).content | Out-File deployWindowsAgent.ps1; (Get-Content deployWindowsAgent.ps1) | Set-Content deployWindowsAgent.ps1
(Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/bseltz-cohesity/scripts/master/powershell/deployWindowsAgent/UserRights.psm1).content | Out-File UserRights.psm1; (Get-Content UserRights.psm1) | Set-Content UserRights.psm1

(Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/bseltz-cohesity/scripts/master/powershell/addRemoteCluster/addRemoteCluster.ps1).content | Out-File addRemoteCluster.ps1; (Get-Content addRemoteCluster.ps1) | Set-Content addRemoteCluster.ps1
(Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/bseltz-cohesity/scripts/master/powershell/addRemoteCluster/cohesityCluster.ps1).content | Out-File cohesityCluster.ps1; (Get-Content cohesityCluster.ps1) | Set-Content cohesityCluster.ps1

$scriptName = 'createProtectionPolicy'
(Invoke-WebRequest -UseBasicParsing -Uri "$repoUrl/$scriptName/$scriptName.ps1").content | Out-File "$scriptName.ps1"; (Get-Content "$scriptName.ps1") | Set-Content "$scriptName.ps1"

## This needs to be download for all scripts
(Invoke-WebRequest -UseBasicParsing -Uri "$repoUrl/cohesity-api/cohesity-api.ps1").content | Out-File cohesity-api.ps1; (Get-Content cohesity-api.ps1) | Set-Content cohesity-api.ps1