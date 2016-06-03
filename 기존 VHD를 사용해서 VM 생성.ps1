## 로그인
Login-AzureRmAccount 

###########################################################
## 이 부분은 직접 자신에 맞게 변수값을 설정해 줘야 한다.
$subscriptionName = "BizSpark"
$resourceGroupName = "rg-jw-taeyo-study"
$location = "japan west"
$VNetName = "vn-jw-taeyo-test"

## 만들 VM의 이름과 크기
$vmname = "PlzRemove"
$vmSize = "Standard_A2"

## VHD 경로
$osDiskVhdUri = "https://taeyostudy.blob.core.windows.net/vhds/TestVMCanRemove2016117155451.vhd"
###########################################################
$osDiskName = $vmName + "_osDisk"
$interfaceName = $vmname + "_Interface"
###########################################################

## 구독 설정
Get-AzureRmSubscription –SubscriptionName $subscriptionName | Select-AzureRmSubscription

## 리소스그룹 살펴보기
## Get-AzureRmResourceGroup | ft ResourceGroupName, location
## Get-AzureRmResourceGroup -Name "rg-jw-taeyo-study"


## VM 인스턴스 만들고, 기존 디스크 연결
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$vm = Set-AzureRmVMOSDisk -VM $vm -VhdUri $osDiskVhdUri -Name $osDiskName -CreateOption attach -Windows -Caching $osDiskCaching

## Network 설정 및 네트워크 카드, 공용 IP(동적) 생성
$publicIp = New-AzureRmPublicIpAddress -Name $interfaceName -ResourceGroupName $resourceGroupName -location $location -AllocationMethod Dynamic
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $VNetName
$Interface = New-AzureRmNetworkInterface -Name $interfaceName -ResourceGroupName $resourceGroupName -location $location -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $publicIp.Id
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $Interface.Id

New-AzureRmVM -location $location -ResourceGroupName $resourceGroupName -VM $vm -Verbose -Debug







## VM 생성시에 네트워크 설정도 모두 하는 경우
## Network
    $interfaceName = "ServerInterface06"
    $Subnet1Name = "Subnet1"
    $VNetName = "VNet09"
    $VNetAddressPrefix = "10.0.0.0/16"
    $VNetSubnetAddressPrefix = "10.0.0.0/24"
# Network
    $PIp = New-AzureRmPublicIpAddress -Name $interfaceName -ResourceGroupName $ResourceGroupName -location $location -AllocationMethod Dynamic
    $SubnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name $Subnet1Name -AddressPrefix $VNetSubnetAddressPrefix
    $VNet = New-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -location $location -AddressPrefix $VNetAddressPrefix -Subnet $SubnetConfig
    $Interface = New-AzureRmNetworkInterface -Name $interfaceName -ResourceGroupName $ResourceGroupName -location $location -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $PIp.Id






Get-AzureRmResourceGroup | ft ResourceGroupName, location

$subscr = "BizSpark"
Get-AzureSubscription –SubscriptionName $subscr | Select-AzureSubscription

	## Global
$resourceGroupName = "rg-jw-taeyo-study"
$location = "japan west"

	## Storage
$storageName = "teststore"
$storageType = "Standard_GRS"

	## Network
$nicname = "testnic"
$subnet1Name = "subnet1"
$vnetName = "testnet"
$vnetAddressPrefix = "10.0.0.0/16"
$vnetSubnetAddressPrefix = "10.0.0.0/24"

## Compute
$vmName = "plzDeletevm"
$computerName = "testcomputer"
$vmSize = "Standard_A2"
$osDiskName = $vmName + "osDisk"
	
	## Setup local VM object
#$cred = Get-Credential
#$nic = New-AzureNetworkInterface -Name $nicname -ResourceGroupName $resourceGroupName -location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id

$vm = New-AzureVMConfig -Name $vmName -InstanceSize $vmSize -DiskName $osDiskName
#$vm = Add-AzureVMNetworkInterface -VM $vm -Id $nic.Id
$osDiskUri = "https://taeyostudy.blob.core.windows.net/vhds/TestVMCanRemove2016117155451.vhd"
$vm = Set-AzureVMOSDisk -VM $vm -Name $osDiskName -VhdUri $osDiskUri -CreateOption attach -Windows
## Create the VM in Azure
New-AzureVM -ResourceGroupName $resourceGroupName -location $location -VM $vm -Verbose -Debug
