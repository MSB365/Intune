#region Description
<#     
       .NOTES
       ===========================================================================
       Created on:         2020/03/03 
       Created by:         Drago Petrovic
       Organization:       MSB365.blog
       Filename:           SetDesktopBackground.ps1     

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
$directory = "C:\MDM\background\"


If ((Test-Path -Path $directory) -eq $false)
{
        New-Item -Path $directory -ItemType directory
}

$folder = "C:\MDM\background"
$url= "https://www.msb365.blog/wp-content/uploads/2019/10/BackGround.jpg"
$req = [System.Net.HttpWebRequest]::Create($url)
$req.Method = "HEAD"
$response = $req.GetResponse()
$fUri = $response.ResponseUri
$filename = [System.IO.Path]::GetFileName($fUri.LocalPath); 
$response.Close()
$target = join-path $folder $filename 
Invoke-WebRequest -Uri $url -OutFile $target


$wallpaperSourceFile = "C:\MDM\background\background.jpg"
Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper"
Start-Sleep -s 1
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $wallpaperSourceFile -PropertyType String
rundll32.exe user32.dll, UpdatePerUserSystemParameters, 0, $false

#
Function Set-WallPaper($Value)

{

 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value

 rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True

}

Set-WallPaper -value "C:\MDM\background\background-ITP.jpg"
#
Start-Sleep -s 1

Push-Location
New-Item "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies" -name System -force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -Name Wallpaper -Value "C:\MDM\background\background.jpg" -PropertyType String