
Login-AzureRmAccount

#####################################################
# 이하 변수 설정
#####################################################
# 구독 설정
$subscr = "<your subscription>"

# 리소스그룹
$rg = "dev-rg-jw-ftp"
# 변경할 네트워크 보안 그룹
$nsg_name = "FtpSvr1-nsg"

# 추가할 포트(시작과 끝)
$dynamicPortFirst = 10000
$dynamicPortLast = 10002

# Priority
$priority = 1001
#####################################################

Get-AzureRmSubscription –SubscriptionName $subscr | Select-AzureRmSubscription

$destinationPortRange = "$dynamicPortFirst-$dynamicPortLast"
$name = "FTP-$destinationPortRange"

Get-AzureRmNetworkSecurityGroup -Name $nsg_name -ResourceGroupName $rg | `
    Add-AzureRmNetworkSecurityRuleConfig -Name $name -Direction Inbound -Priority $priority `
    -Access Allow -SourceAddressPrefix '*'  -SourcePortRange '*' -DestinationAddressPrefix '*' `
    -DestinationPortRange $destinationPortRange -Protocol 'TCP' -Description "Allow FTP" | `
    Set-AzureRmNetworkSecurityGroup

Write-Host -Fore Green "Adding: $name"
