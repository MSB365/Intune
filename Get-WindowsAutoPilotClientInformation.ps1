#region Description
<#     
       .NOTES
       ===========================================================================
       Created on:         2020/03/03 
       Created by:         Drago Petrovic
       Organization:       MSB365.blog
       Filename:           Get-WindowsAutoPilotClientInformation.ps1     

       Find us on:
             * Website:  https://www.msb365.blog
             * Technet:  https://social.technet.microsoft.com/Profile/MSB365
             * LinkedIn: https://www.linkedin.com/in/drago-petrovic/
             * Xing:     https://www.xing.com/profile/Drago_Petrovic
       ===========================================================================
       .DESCRIPTION
             
       
       .NOTES
             

       .COPYRIGHT
       Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
       to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
       and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

       The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
       FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
       WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
       ===========================================================================
       .CHANGE LOG
             V0.10, 2020/03/03 - Initial version




--- keep it simple, but significant ---


--- by MSB365 Blog ---

#>
#endregion
Write-Host "--- keep it simple, but significant ---" -ForegroundColor Magenta
Start-Sleep -s 1

#Create Directory ans set Download Path
Write-Host "Create Directory" -ForegroundColor Cyan
$directory = "C:\AutopilotInfo\"
If ((Test-Path -Path $directory) -eq $false)
{
        New-Item -Path $directory -ItemType directory
}
Start-Sleep -s 1
Write-Host "Directory $directory created" -ForegroundColor Cyan

Set-Location c:\\AutopilotInfo
Write-Host "Done!" -ForegroundColor Green
Start-Sleep -s 1

#Install PowerShell Module for AutoPilot
Write-Host "Installing PowerShell Module for getting AutoPilot hash" -ForegroundColor Cyan
Install-Script -Name Get-WindowsAutoPilotInfo
Write-Host "Done" -ForegroundColor Green
Start-Sleep -s 1

#Get and save Client hash
Write-Host "Get Client information" -ForegroundColor Cyan
Get-WindowsAutoPilotInfo.ps1 -OutputFile AutoPilotHWID.csv
Write-Host "Done!" -ForegroundColor Green
Start-Sleep -s 1
Write-Host "Client hash successfully downloaded!" -ForegroundColor Cyan
Start-Sleep -s 1
Write-Host "Get the CSV Fil on $directory" -ForegroundColor Cyan
Start-Sleep -s 1
Invoke-Item $directory