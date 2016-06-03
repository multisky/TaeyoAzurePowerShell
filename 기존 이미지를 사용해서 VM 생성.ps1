## 로그인
Login-AzureRmAccount

###########################################################
## 이 부분은 직접 자신에 맞게 변수값을 설정해 줘야 한다.
$subscriptionName = "<구독이름>" # "MyMSDN"
$resourceGroupName = "<리소스 그룹 이름"> # "rg-jw-taeyo-study"
$location = "<위치">  # japan west"
$VNetName = "<가상 네트워크 이름>"  # vn-jw-taeyo-test"
$storageAccountName = "taeyostudy"

## 만들 VM의 이름과 크기
$vmname = "<만들어질 VM 이름">     # "PlzRemove"
$vmSize = "<만들어질 VM 크기">     # "Standard_A2"

## 만들 관리자 계정
$user = "<만들어질 관리자 아이디>"          # "localadmin"
$password = "<만들어질 관리자 비밀번호>"    # "Xodh!220""

## 이미지 경로
$urlOfCapturedImageVhd = "<이미지 파일의 FQDN 경로>"
# "https://taeyostudy.blob.core.windows.net/system/Microsoft.Compute/Images/mytemplates/template-osDisk.7a38ab93-9215-48b1-813d-a612d3fcf325.vhd"

###########################################################
$osDiskName = $vmName + "_osDisk"
$interfaceName = $vmname + "_Interface"
###########################################################

## 구독 설정
Get-AzureRmSubscription –SubscriptionName $subscriptionName | Select-AzureRmSubscription

$storageAccount = Get-AzureRmStorageAccount | ? StorageAccountName -EQ $storageAccountName

## VM 이름과 크기 지
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

## 계정 및 OS 설정
$cred = New-Object PSCredential $user, ($password | ConvertTo-SecureString -AsPlainText -Force) # you could use Get-Credential instead to get prompted
## NOTE: if you are deploying a Linux machine, replace the -Windows switch with a -Linux switch.
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate

## Network 설정 및 네트워크 카드, 공용 IP(동적) 생성
$publicIp = New-AzureRmPublicIpAddress -Name $interfaceName -ResourceGroupName $resourceGroupName -location $location -AllocationMethod Dynamic
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $VNetName
$Interface = New-AzureRmNetworkInterface -Name $interfaceName -ResourceGroupName $resourceGroupName -location $location -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $publicIp.Id
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $Interface.Id

## OS 디스크 지정
$osDiskUri = '{0}vhds/{1}.vhd' -f $storageAccount.PrimaryEndpoints.Blob.ToString(), $osDiskName
# NOTE: if you are deploying a Linux machine, replace the -Windows switch with a -Linux switch.
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $osDiskName -VhdUri $osDiskUri -CreateOption fromImage -SourceImageUri $urlOfCapturedImageVhd  -Windows

New-AzureRmVM -location $location -ResourceGroupName $resourceGroupName -VM $vm -Verbose -Debug
