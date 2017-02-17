Login-AzureRmAccount

#####################################################
# 이하 변수 설정
#####################################################
$subscr = '<your subscription name>'

$rgName = '<resource group name>'
$location = '<locaton name>'  # ex : japan west

# Subnet and Virtual Network
$vnetName = '<Virtual Network Name>' # ex : vn-test
$ventAddress = '<Virtual Network Address>' # ex : 10.0.0.0/16
$subnetName = '<Subnet Name>' # ex : Frontend
$subnetAddress = '<Subnet Address>' # ex : 10.0.0.0/24

$newVMName = '<VM name you are creating>'
$newVMSize = '<VM size>' # ex : Standard_A2

#**********************************************************************#
$osDiskName = '<managed OS Diak Name>' # Existing OS managed disk name
#**********************************************************************#

Get-AzureRmSubscription –SubscriptionName $subscr | Select-AzureRmSubscription

# Check if resource group exist
$rg = Get-AzureRmResourceGroup | where {$_.ResourceGroupName -eq $rgName}
if(!$rg)
{
    write-Host "Resource Group '$rgName' doesn't exist. check it again!" -ForegroundColor Yellow
    return
}

# Check if managed OS disk exist
$disk = Get-AzureRmDisk -ResourceGroupName $rgName | where {$_.Name -eq $osDiskName}
if(!$disk)
{
    write-Host "Managed Disk '$osDiskName' doesn't exist. check it again!" -ForegroundColor Yellow
    return
}

$vnet = Get-AzureRmVirtualNetwork | where {$_.name -eq $vnetName}
$subnet = $vnet | Get-AzureRmVirtualNetworkSubnetConfig | where {$_.name -eq $subnetName}

if(!$vnet)  # vnet not exist
{
    write-Host "'$vnetName' network doesn't exist. so, we're creating it now..." -ForegroundColor Green
    $singleSubnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddress
    $vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $location `
        -AddressPrefix $ventAddress -Subnet $singleSubnet
}
else    # vnet exist
{
    if(!$subnet)   # sunbet not exist
    {
        write-Host "Subnet '$subnetName' doesn't exist. check it again!" -ForegroundColor Yellow
        return
    }
}

# Create Public IP
$ipName = $newVMName + "-pip"
$pip = New-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $rgName -Location $location `
    -AllocationMethod Dynamic

# Create Network Interface
$nicName = $newVMName + "-nic"
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName `
 -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id

# Create Network Security Group
$nsgName = $newVMName + "-nsg"
$rdpRule = New-AzureRmNetworkSecurityRuleConfig -Name myRdpRule -Description "Allow RDP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 3389
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $rgName -Location $location `
    -Name $nsgName -SecurityRules $rdpRule
#--------------------------------------------------

# Set the VM name and size
$vmConfig = New-AzureRmVMConfig -VMName $newVMName -VMSize $newVMSize

# Add the NIC to VM
$vm = Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $nic.Id

# Get Managed OS Disk 
$osDisk = Get-AzureRmDisk -ResourceGroupName $rgName -DiskName $osDiskName

# Configure the OS disk
$vm = Set-AzureRmVMOSDisk -VM $vm -ManagedDiskId $osDisk.Id -StorageAccountType StandardLRS `
 -DiskSizeInGB 128 -CreateOption Attach -Windows -Caching ReadWrite 

#Create the new VM
write-Host "'$newVmName' VM is creating..." -ForegroundColor Green
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm

