Login-AzureRmAccount

#####################################################
# 이하 변수 설정
#####################################################
$subscr = '<your subscription name>'

$rgName = '<resource group name>'
$vmName = '<VM name that you want to attach data disk>'

#***********************************************************************************#
$dataDiskName = '<managed Data Diak Name>' # Existing Data managed disk name
#***********************************************************************************#

Get-AzureRmSubscription –SubscriptionName $subscr | Select-AzureRmSubscription

# Get Managed Disk 
$dataDisk = Get-AzureRmDisk -ResourceGroupName $rgName -DiskName $dataDiskName

# Get VM
$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName

# Attach Managed Data Disk to VM
$vm = Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1

# Update VM
Update-AzureRmVM -VM $vm -ResourceGroupName $rgName

#----------------------------------
#################################################################################
#################################################################################
# Addtional Script for Detaching ################################################
#################################################################################
# Detach Managed Data Disk to VM
$vm = Remove-AzureRmVMDataDisk  -VM $vm -DataDiskNames $dataDiskName

# Update VM
Update-AzureRmVM -VM $vm -ResourceGroupName $rgName
