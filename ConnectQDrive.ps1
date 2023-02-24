$connectTestResult = Test-NetConnection -ComputerName wdnstorage.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"wdnstorage.file.core.windows.net`" /user:`"localhost\wdnstorage`" /pass:`"sDHDIA4DCI621/mk1QlO5AYu60uit1EmtuLm9XixuEZTbyilm0YjE+UCeD0lUUCQrUxRncg3YQeEfjGru/gS5Q==`""
    # Mount the drive
    New-PSDrive -Name Q -PSProvider FileSystem -Root "\\wdnstorage.file.core.windows.net\quickbooks" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}