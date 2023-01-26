#Numbers of lines will probably need to change when edits to RSBE01.txt or BOOST.txt are made.

copy "../Build/BrawlTP+/RSBE01.txt" "../Build/BrawlTP+/NETPLAY.txt" -Force -erroraction 'silentlycontinue'
copy "../Build/BrawlTP+/BOOST.txt" "../Build/BrawlTP+/NETBOOST.txt" -Force -erroraction 'silentlycontinue'
copy "../NetplayFiles/seal" "../Build/BrawlTP+/pf/toy/" -Force -Recurse -erroraction 'silentlycontinue'
copy "../NetplayFiles/Netplay" "../Build/BrawlTP+/Source/" -Force -Recurse -erroraction 'silentlycontinue'
copy "../NetplayFiles/dnet.cmnu" "../Build/BrawlTP+/pf/menu3/" -Force -erroraction 'silentlycontinue'
del "../Build/BrawlTP+/pf/sound/netplaylist" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
Copy-Item "../Build/BrawlTP+/pf/sound/tracklist" -Destination "../Build/Project+/pf/sound/netplaylist" -Force -Recurse -erroraction 'silentlycontinue'
del "../Build/BrawlTP+/st/" -Confirm:$false -Recurse -erroraction 'silentlycontinue'

#NETPLAY.txt
$netplayPath = "..\Build\BrawlTP+\NETPLAY.txt"
(Get-Content $netplayPath).replace('Source/Project+/MultiGCT.asm', 'Source/Netplay/Net-MultiGCT.asm') | Set-Content $netplayPath
(Get-Content $netplayPath).replace('Source/Project+/CodeMenu.asm', 'Source/Netplay/Net-CodeMenu.asm') | Set-Content $netplayPath
$netplayContent = Get-Content $netplayPath
$netplayContent[15] += "`r`n`r`n# Netplay Codeset Differences:`r`n"
$netplayContent[15] += "#`r`n"
$netplayContent[15] += "# NETBOOST.GCT is loaded instead of BOOST.GCT (see bottom of codeset)`r`n"
$netplayContent[15] += '# "Source/Netplay/Net-CodeMenu.asm" is loaded instead of "Source/Project+/CodeMenu.asm"'
$netplayContent[15] += "`r`n#`r`n"
$netplayContent[15] += "#############################################################################"
$netplayContent | Set-Content $netplayPath

#NETBOOST.txt
$netboostPath = "..\Build\Project+\NETBOOST.txt"
(Get-Content $netboostPath).replace('Source/Project+/StageFiles.asm', 'Source/Netplay/Net-StageFiles.asm') | Set-Content $netboostPath
(Get-Content $netboostPath).replace('.include Source/Extras/Console.asm', '#.include Source/Extras/Console.asm') | Set-Content $netboostPath
(Get-Content $netboostPath).replace('#.include Source/Extras/Netplay.asm', '.include Source/Extras/Netplay.asm') | Set-Content $netboostPath

#Net-MultiGCT
(Get-Content "..\Build\Project+\Source\Project+\MultiGCT.asm") -replace 'BOOST.GCT', 'NETBOOST.GCT' | Out-File -encoding ASCII "..\Build\Project+\Source\Netplay\Net-MultiGCT.asm"

#Net-StageFiles
$stagefilesPath = "..\Build\BrawlTP+\Source\Netplay\Net-StageFiles.asm"
(Get-Content "..\Build\BrawlTP+\Source\Project+\StageFiles.asm") -replace '/sound/tracklist/', '/sound/netplaylist/' | Out-File -encoding ASCII $stagefilesPath
(Get-Content $stagefilesPath).replace('source/Project+/MyMusic.asm', 'source/Netplay/Net-MyMusic.asm') | Set-Content $stagefilesPath
$stagefilesContent = Get-Content $stagefilesPath
$stagefilesContent[0] = "#`r`n"
$stagefilesContent[0] += "# This file is nearly identical to Project+/StageFiles.asm but changes the following:`r`n"
$stagefilesContent[0] += "# -it points to Netplay/Net-MyMusic.asm instead of Project+/MyMusic.asm`r`n"
$stagefilesContent[0] += '# -string "/sound/tracklist/" -> "sound/netplaylist/"'
$stagefilesContent[0] += "`r`n#`r`n#################################"
$stagefilesContent | Set-Content $stagefilesPath

#RSBE01.txt
$rsbe01Path = "..\Build\BrawlTP+\RSBE01.txt"
$strapcode = Select-String -Path $rsbe01Path -Pattern "046CADE8"
if ($strapcode -eq $null)
{
	(Get-Content $rsbe01Path).replace('80078E14', "80078E14`r`n* 046CADE8 48000298") | Set-Content $rsbe01Path
}