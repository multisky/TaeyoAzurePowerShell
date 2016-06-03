## 로그인
Login-AzureRmAccount

###########################################################
## 이 부분은 직접 자신에 맞게 변수값을 설정해 줘야 한다.
$subscr = "<구독이름>" # "MyMSDN"
$resourceGroupName = "<리소스 그룹 이름"> # "rg-jw-taeyo-study"
$vmname = "<만들어질 VM 이름">     # "PlzRemove"
###########################################################

$imageName = $vmname + "_CapturedImage"

Get-AzureRmSubscription –SubscriptionName $subscr | Select-AzureRmSubscription

# Deallocate the virtual machine
Stop-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmname 

# Set the Generalized state to the virtual machine
Set-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmname -Generalized  

# Capture the image to storage account.
Save-AzureRmVMImage -ResourceGroupName $resourceGroupName -VMName $vmname `
    -DestinationContainerName 'mytemplates' -VHDNamePrefix 'template' `
    -Path C:\temp\capturevmtest\SampleTemplate.json  



