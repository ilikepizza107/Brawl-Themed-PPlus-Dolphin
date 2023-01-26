del "..\Build\BrawlTP+\NETPLAY.txt" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\BrawlTP+\NETBOOST.txt" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\BrawlTP+\pf\menu3\dnet.cmnu" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\BrawlTP+\pf\movie" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\BrawlTP+\pf\sound\netplaylist" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\BrawlTP+\Source\Netplay" -Confirm:$false -Recurse -erroraction 'silentlycontinue'
del "..\Build\BrawlTP+\pf\toy\seal" -Confirm:$false -Recurse -erroraction 'silentlycontinue'

#RSBE01.txt
$rsbe01Path = "..\Build\BrawlTP+\RSBE01.txt"
$strapcode = Select-String -Path $rsbe01Path -Pattern "046CADE8"
if ($strapcode -ne $null)
{
	(Type "..\Build\BrawlTP+\RSBE01.txt") -notmatch "^* 046CADE8 48000298$" | Set-Content "..\Build\BrawlTP+\RSBE01.txt"
}