## 로그인
Login-AzureRmAccount

## 구독 설정
$subscr = "BizSpark"
$resourceGroupName = "rg-jw-taeyo-study"
$vmname = "PlzRemove"
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



