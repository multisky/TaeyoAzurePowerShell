######################################################################
## 설정해야 하는 변수들 #################################################

### 원본 BLOB 파일 ###
$srcUri = "<원본 Blob 파일 URL>" ## https://taeyostudy.blob.core.windows.net/vhds2/ASP.NET%20MVC%205.pdf" 
$destBlobName = "<대상 경로에 생성될 Blob 파일 이름>" ## "ASP.NET.MVC.pdf"
 
### 원본 저장소 계정 (Japan West) ###
$srcStorageAccount = "<원본 저장소 계정>" ## taeyostudy"   ## V2 Storage
$srcStorageKey = "<원본 저장소 키>" ## ...cr/2hAoYr1OA7b7jQ=="
 
### 대상 저장소 계정 (East Asis) ###
$destStorageAccount = "<대상 저장소 계정>"  ## "taeyoDest"      ## V1 Storage
$destStorageKey = "<대상 저장소 키>" ## "..frf0buthhaJqMhv9ew=="

### 대상 컨테이너 명 ### 
$destContainerName = "<대상 컨테이너 이름(없으면 자동으로 생성됨)>" ## "vhd-backup"
######################################################################
 
### 원본 저장소 계정 컨텍스트 생성 ### 
$srcContext = New-AzureStorageContext  –StorageAccountName $srcStorageAccount `
                                       -StorageAccountKey $srcStorageKey  
 
### 대상 저장소 계정 컨텍스트 생성 ### 
$destContext = New-AzureStorageContext  –StorageAccountName $destStorageAccount `
                                        -StorageAccountKey $destStorageKey 

try
{   
    Get-AzureStorageContainer -Name $containerName -Context $destContext -ErrorAction Stop
}
catch [Microsoft.WindowsAzure.Commands.Storage.Common.ResourceNotFoundException]
{
    ## 컨테이너가 존재하지 않으면 생성.
    New-AzureStorageContainer -Name $containerName -Context $destContext 
}
 
### 비동기 복사 시작 ### 
$blob1 = Start-AzureStorageBlobCopy -srcUri $srcUri `
                                    -SrcContext $srcContext `
                                    -DestContainer $containerName `
                                    -DestBlob $destBlobName `
                                    -DestContext $destContext

### 복사 중인 작업의 현재 상태를 가져온다 ###
$status = $blob1 | Get-AzureStorageBlobCopyState 
 
### 상태를 출력 ### 
$status 
 
### 완료될 때까지 반복해서 출력 (10초 간격) ###                                    
While($status.Status -eq "Pending"){
  $status = $blob1 | Get-AzureStorageBlobCopyState 
  Start-Sleep 10
  ### 상태를 출력 ### 
  $status
}



###Stop-AzureStorageBlobCopy -Blob $destBlobName -Context $destContext -Container $containerName
