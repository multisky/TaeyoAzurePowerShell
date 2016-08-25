# 다양한 PowerShell 샘플

>개인적으로 필요에 의해 만들어 놓은 Azure PowerShell 샘플들

- [기존 VHD를 사용해서 VM(V2-ARM) 생성](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/%EA%B8%B0%EC%A1%B4%20VHD%EB%A5%BC%20%EC%82%AC%EC%9A%A9%ED%95%B4%EC%84%9C%20VM%20%EC%83%9D%EC%84%B1.ps1)
    - 기존 VM에서 분리된 VHD 파일(sysprep되지 않은 상태)을 사용하여 VM을 만드는 경우를 위한 예제
    - 파일 이동은 [Microsoft Storage Explorer](http://storageexplorer.com/)을 사용하면 편함.
- [V2-ARM : ARM에서 Capture하는 방법](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/ARM%EC%97%90%EC%84%9C%20Capture%ED%95%98%EB%8A%94%20%EB%B0%A9%EB%B2%95.ps1)
    - Azure 신규 포탈에서 운영 중인 VM을 sysprep 하는 방법
    - 이 작업에 앞서 RDP로 VM에 접속해서 sysprep을 해주어야 함.
    > sysprep.exe /generalize /oobe /shutdown    

    - sysprep 실행 후 VM이 종료되면 이 PowerShell을 실행해야 함. 
    - 자세한 과정은 [스텝 바이 스텝 문서](https://azure.microsoft.com/ko-kr/documentation/articles/virtual-machines-windows-capture-image/) 참고
- [V2-ARM : 기존 이미지를 사용해서 VM 생성](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/%EA%B8%B0%EC%A1%B4%20%EC%9D%B4%EB%AF%B8%EC%A7%80%EB%A5%BC%20%EC%82%AC%EC%9A%A9%ED%95%B4%EC%84%9C%20VM%20%EC%83%9D%EC%84%B1.ps1)
    - 이미 sysprep 되어서 Image가 되어 있는 파일을 이용해서 VM을 만드는 예제
    - 위의 'ARM에서 Capture하는 방법'을 따라 캡춰된 이미지를 사용해야 함
- [Blob 파일을 다른 구독의 다른 저장소 계정으로 옮기는 방법](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/Blob%20%ED%8C%8C%EC%9D%BC%EC%9D%84%20%EB%8B%A4%EB%A5%B8%20%EA%B5%AC%EB%8F%85%EC%9D%98%20%EB%8B%A4%EB%A5%B8%20%EC%A0%80%EC%9E%A5%EC%86%8C%EA%B3%84%EC%A0%95%EC%9C%BC%EB%A1%9C%20%EC%98%AE%EA%B8%B0%EB%8A%94%20%EB%B0%A9%EB%B2%95.ps1)
    - 저장소 키를 활용하여 구독 간에 Blob 파일을 이동하는 방법
    - 보유하고 있는 구독 간에만 사용하는 것이 좋음(저장소 키는 외부 공개하지 않는 것이 바람직함).
- [리눅스 VM의 OS 디스크 Resize](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/%EB%A6%AC%EB%88%85%EC%8A%A4%20VM%EC%9D%98%20OS%20%EB%94%94%EC%8A%A4%ED%81%AC%20Resize.ps1)
    - 이미 생성되어 있는 Linux의 OS 크기 변경하는 방법
    - [원본 참고 링크는 여기임](https://blogs.msdn.microsoft.com/cloud_solution_architect/2016/05/24/step-by-step-how-to-resize-a-linux-vm-os-disk-in-azure-arm/)


----
도움 : [성지용](https://github.com/jiyongseong) 