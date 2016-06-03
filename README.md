# 다양한 PowerShell 샘플

>개인적으로 필요에 의해 만들어 놓은 Azure PowerShell 샘플들

- 기존 VHD를 사용해서 VM 생성
    - 기존 VM에서 분리된 VHD 파일(sysprep되지 않은 상태)을 사용하여 VM을 만드는 경우를 위한 예제
    - 파일 이동은 [Microsoft Storage Explorer](http://storageexplorer.com/)을 사용하면 편함.
- ARM에서 Capture하는 방법
    - Azure 신규 포탈에서 운영 중인 VM을 sysprep 하는 방법
    - 이 작업에 앞서 RDP로 VM에 접속해서 sysprep을 해주어야 함.
    - 자세한 과정은 [스텝 바이 스텝 문서](https://azure.microsoft.com/ko-kr/documentation/articles/virtual-machines-windows-capture-image/) 참고
- 기존 이미지를 사용해서 VM 생성
    - 이미 sysprep 되어서 Image가 되어 있는 파일을 이용해서 VM을 만드는 예제
    - 위의 'ARM에서 sysprerp하는 방법'을 따라 캡춰된 이미지를 사용해야 함
    
