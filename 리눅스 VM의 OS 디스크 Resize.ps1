###########################################################
## 이 부분은 직접 자신에 맞게 변수값을 설정해 줘야 한다.
$subscriptionName = "<구독이름>" ## "BizSpark"
$rg = "<리소스 그룹 이름>" ## "rg-jw-taeyo-study"

## 대상 VM의 이름
$vmName = "<대상 VM의 이름>" ## "PlzDelme"
###########################################################

$vm = Get-AzureRmVM -ResourceGroupName $rg -Name $vmName
$vm.StorageProfile[0].OSDisk[0].DiskSizeGB = 127  # change the size as required
Update-AzureRmVM –ResourceGroupName $rg -VM $vm


