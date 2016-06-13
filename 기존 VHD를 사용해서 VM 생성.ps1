## 로그인
Login-AzureRmAccount 

###########################################################
## 이 부분은 직접 자신에 맞게 변수값을 설정해 줘야 한다.
$subscriptionName = "<구독이름>" # "MyMSDN"
$resourceGroupName = "<리소스 그룹 이름>" # "rg-jw-taeyo-study"
$location = "<위치>"  # japan west"
$VNetName = "<가상 네트워크 이름>"  # vn-jw-taeyo-test"

## 만들 VM의 이름과 크기
$vmname = "<만들어질 VM 이름>"     # "PlzRemove"
$vmSize = "<만들어질 VM 크기>"     # "Standard_A2"

## VHD 경로
$osDiskVhdUri = "<VHD 파일의 FQDN 경로>" 
# "https://taeyostudy.blob.core.windows.net/vhds/TestVMCanRemove2016117155451.vhd"

###########################################################
$osDiskName = $vmName + "_osDisk"
$interfaceName = $vmname + "_Interface"
###########################################################

## 구독 설정
Select-AzureRmSubscription –SubscriptionName $subscriptionName

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
