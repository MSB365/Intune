 #region Description
<#     
       .NOTES
       ===========================================================================
       Created on:         2020/06/25 
       Created by:         Drago Petrovic
       Organization:       MSB365.blog
       Filename:           ClientConfigTool.ps1     

       Find us on:
             * Website:  https://www.msb365.blog
             * Technet:  https://social.technet.microsoft.com/Profile/MSB365
             * LinkedIn: https://www.linkedin.com/in/drago-petrovic/
             * Xing:     https://www.xing.com/profile/Drago_Petrovic
       ===========================================================================
       .DESCRIPTION
        PowerShell based GUI Tool for exporting the Intune configuration as a JSON File to create a Bootable USB Install Stick.
		This GUI also can activate a Windows 10 Device with a promoted Microsoft KEY.
		Last but not least the User can perform a local Domain Join using this Tool
       
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
             V0.10, 2020/06/25 - Initial version
             V0.20, 2020/07/01 - Making Script working




--- keep it simple, but significant ---


--- by MSB365 Blog ---

#>
#endregion

#region Logo
Write-Host "MMMMMMMM               MMMMMMMM   SSSSSSSSSSSSSSS BBBBBBBBBBBBBBBBB   " -ForegroundColor gray -NoNewline 
Write-Host " 333333333333333           66666666   555555555555555555 " -ForegroundColor yellow
Write-Host "M:::::::M             M:::::::M SS:::::::::::::::SB::::::::::::::::B  " -ForegroundColor gray -NoNewline 
Write-Host "3:::::::::::::::33        6::::::6    5::::::::::::::::5 " -ForegroundColor yellow
Write-Host "M::::::::M           M::::::::MS:::::SSSSSS::::::SB::::::BBBBBB:::::B " -ForegroundColor gray -NoNewline 
Write-Host "3::::::33333::::::3      6::::::6     5::::::::::::::::5 " -ForegroundColor yellow
Write-Host "M:::::::::M         M:::::::::MS:::::S     SSSSSSSBB:::::B     B:::::B" -ForegroundColor gray -NoNewline 
Write-Host "3333333     3:::::3     6::::::6      5:::::555555555555 " -ForegroundColor yellow
Write-Host "M::::::::::M       M::::::::::MS:::::S              B::::B     B:::::B" -ForegroundColor gray -NoNewline 
Write-Host "            3:::::3    6::::::6       5:::::5            " -ForegroundColor yellow
Write-Host "M:::::::::::M     M:::::::::::MS:::::S              B::::B     B:::::B" -ForegroundColor gray -NoNewline 
Write-Host "            3:::::3   6::::::6        5:::::5            " -ForegroundColor yellow
Write-Host "M:::::::M::::M   M::::M:::::::M S::::SSSS           B::::BBBBBB:::::B " -ForegroundColor gray -NoNewline 
Write-Host "    33333333:::::3   6::::::6         5:::::5555555555   " -ForegroundColor yellow
Write-Host "M::::::M M::::M M::::M M::::::M  SS::::::SSSSS      B:::::::::::::BB  " -ForegroundColor gray -NoNewline 
Write-Host "    3:::::::::::3   6::::::::66666    5:::::::::::::::5  " -ForegroundColor yellow
Write-Host "M::::::M  M::::M::::M  M::::::M    SSS::::::::SS    B::::BBBBBB:::::B " -ForegroundColor gray -NoNewline 
Write-Host "    33333333:::::3 6::::::::::::::66  555555555555:::::5 " -ForegroundColor yellow
Write-Host "M::::::M   M:::::::M   M::::::M       SSSSSS::::S   B::::B     B:::::B" -ForegroundColor gray -NoNewline 
Write-Host "            3:::::36::::::66666:::::6             5:::::5" -ForegroundColor yellow
Write-Host "M::::::M    M:::::M    M::::::M            S:::::S  B::::B     B:::::B" -ForegroundColor gray -NoNewline 
Write-Host "            3:::::36:::::6     6:::::6            5:::::5" -ForegroundColor yellow
Write-Host "M::::::M     MMMMM     M::::::M            S:::::S  B::::B     B:::::B" -ForegroundColor gray -NoNewline 
Write-Host "            3:::::36:::::6     6:::::65555555     5:::::5" -ForegroundColor yellow
Write-Host "M::::::M               M::::::MSSSSSSS     S:::::SBB:::::BBBBBB::::::B" -ForegroundColor gray -NoNewline 
Write-Host "3333333     3:::::36::::::66666::::::65::::::55555::::::5" -ForegroundColor yellow
Write-Host "M::::::M               M::::::MS::::::SSSSSS:::::SB:::::::::::::::::B " -ForegroundColor gray -NoNewline 
Write-Host "3::::::33333::::::3 66:::::::::::::66  55:::::::::::::55 " -ForegroundColor yellow
Write-Host "M::::::M               M::::::MS:::::::::::::::SS B::::::::::::::::B  " -ForegroundColor gray -NoNewline 
Write-Host "3:::::::::::::::33    66:::::::::66      55:::::::::55   " -ForegroundColor yellow
Write-Host "MMMMMMMM               MMMMMMMM SSSSSSSSSSSSSSS   BBBBBBBBBBBBBBBBB   " -ForegroundColor gray -NoNewline 
Write-Host " 333333333333333        666666666          555555555     " -ForegroundColor yellow

Write-Host "                ------------------------------------------------------------------------------------------------------         " -ForegroundColor magenta
Write-Host "                        ┬┌─┌─┐┌─┐┌─┐  ┬┌┬┐  ┌─┐┬┌┬┐┌─┐┬  ┌─┐       ┌┐ ┬ ┬┌┬┐  ┌─┐┬┌─┐┌┐┌┬┌─┐┬┌─┐┌─┐┌┐┌┌┬┐" -ForegroundColor cyan
Write-Host "                        ├┴┐├┤ ├┤ ├─┘  │ │   └─┐││││├─┘│  ├┤   ───  ├┴┐│ │ │   └─┐││ ┬││││├┤ ││  ├─┤│││ │ " -ForegroundColor cyan
Write-Host "                        ┴ ┴└─┘└─┘┴    ┴ ┴   └─┘┴┴ ┴┴  ┴─┘└─┘       └─┘└─┘ ┴   └─┘┴└─┘┘└┘┴└  ┴└─┘┴ ┴┘└┘ ┴ " -ForegroundColor cyan 
Start-Sleep -s 2
#endregion
     
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="MSB365 - Cliet configuration Tool" 
    $MyForm.Size = New-Object System.Drawing.Size(1200,800) 
     

#----------------------------------------------------------------------------------------------------------------------------------------

        $mIntuneTitle = New-Object System.Windows.Forms.Label ######################### Title Intune Config File
                $mIntuneTitle.Text="Export Intune Configuration File" 
                $mIntuneTitle.Top="49" 
                $mIntuneTitle.Left="20" 
                $mIntuneTitle.Anchor="Left,Top" 
        $mIntuneTitle.Size = New-Object System.Drawing.Size(200,20) 
        $MyForm.Controls.Add($mIntuneTitle) 
         
 
        $mIntuneUsername = New-Object System.Windows.Forms.Label ######################### Title Intune Username
                $mIntuneUsername.Text="Username" 
                $mIntuneUsername.Top="95" 
                $mIntuneUsername.Left="45" 
                $mIntuneUsername.Anchor="Left,Top" 
        $mIntuneUsername.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mIntuneUsername) 
         
 
        $mIntunePassword = New-Object System.Windows.Forms.Label ######################### Title Intune Password
                $mIntunePassword.Text="Password" 
                $mIntunePassword.Top="132" 
                $mIntunePassword.Left="45" 
                $mIntunePassword.Anchor="Left,Top" 
        $mIntunePassword.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mIntunePassword) 
         
 
        $mIntuneDestinationPath = New-Object System.Windows.Forms.Label ######################### Title Intune Path
                $mIntuneDestinationPath.Text="Select Destination Path" 
                $mIntuneDestinationPath.Top="169" 
                $mIntuneDestinationPath.Left="45" 
                $mIntuneDestinationPath.Anchor="Left,Top" 
        $mIntuneDestinationPath.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mIntuneDestinationPath)


                $mIntuneBoxUsername = New-Object System.Windows.Forms.TextBox ######################### Variable Intune Username
                $mIntuneBoxUsername.Text="Username" 
                $mIntuneBoxUsername.Top="92" 
                $mIntuneBoxUsername.Left="195" 
                $mIntuneBoxUsername.Anchor="Left,Top" 
        $mIntuneBoxUsername.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mIntuneBoxUsername) 
         
 
        $mIntuneBoxPassword = New-Object System.Windows.Forms.TextBox ######################### Variable Intune Password
                $mIntuneBoxPassword.Text="Password" 
                $mIntuneBoxPassword.Top="129" 
                $mIntuneBoxPassword.Left="195" 
                $mIntuneBoxPassword.Anchor="Left,Top" 
        $mIntuneBoxPassword.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mIntuneBoxPassword) 
         
 
        $mIntuneGridPath = New-Object System.Windows.Forms.TextBox ######################### Variable Intune Path
                $mIntuneGridPath.Text="Path" 
                $mIntuneGridPath.Top="166" 
                $mIntuneGridPath.Left="195" 
                $mIntuneGridPath.Anchor="Left,Top" 
        $mIntuneGridPath.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mIntuneGridPath) 



        $mIntuneRun = New-Object System.Windows.Forms.Button ######################### Button - Get Intune JSON
                $mIntuneRun.Text="Export" 
                $mIntuneRun.Top="91" 
                $mIntuneRun.Left="469" 
                $mIntuneRun.Anchor="Left,Top" 
        $mIntuneRun.Size = New-Object System.Drawing.Size(200,100) 
        $mIntuneRun.add_Click
        $MyForm.Controls.Add($mIntuneRun) 
                $mIntuneRun.Add_Click(
                                        {
                                        $var01 = "microsoft.graph.intune"
                                        Function Get-MyModule
                                            {
                                            Param([string]$name)
                                            if(-not(Get-Module -name $var01))
                                                {
                                                if(Get-Module -ListAvailable |
                                                Where-Object { $_.name -eq $var01 })
                                                    {
                                                    Import-Module -Name $var01
                                                    $true
                                                    } #end if module available then import
                                                else 
                                                    { Install-Module -Name $var01 -force}
                                                    }
                                                else 
                                                    { $true } #module already loaded
                                                } #end function get-MyModule
                                        get-mymodule -name $var01
                                        
                                        $var02 = "WindowsAutopilotIntune"
                                        Function Get-MyModule
                                                {
                                                Param([string]$name)
                                                if(-not(Get-Module -name $var02))
                                                    {
                                                    if(Get-Module -ListAvailable |
                                                    Where-Object { $_.name -eq $var02 })
                                                        {
                                                        Import-Module -Name $var02
                                                        $true
                                                        } #end if module available then import
                                                  else 
                                                        { Install-Module -Name $var02 -force}
                                                        }
                                                  else 
                                                        { $true } #module already loaded
                                                        } #end function get-MyModule
                                        get-mymodule -name $var02
                                        
                                        $secure_pwd = $mIntuneBoxPassword.Text | ConvertTo-SecureString -AsPlainText -Force
                                        $creds = New-Object System.Management.Automation.PSCredential -ArgumentList $mIntuneBoxUsername.Text, $secure_pwd


                                        get-module microsoft.graph.intune
                                        get-module WindowsAutopilotIntune
                                        connect-msgraph -Credential $creds

                                        $config = Get-AutopilotProfile | ogv -PassThru
                                        $config = Get-AutopilotProfile
                                        Get-Command -Module WindowsAutopilotIntune
                                        $res = $mIntuneGridPath.Text
                                        $config | ConvertTo-AutopilotConfigurationJSON | Out-File $res\AutopilotConfiguration.json -Encoding ascii
                                        }
                                 )
#----------------------------------------------------------------------------------------------------------------------------------------
 
         $mKEYTitle = New-Object System.Windows.Forms.Label ######################### Title KEY Windows 10
                $mKEYTitle.Text="Activate Windows 10" 
                $mKEYTitle.Top="261" 
                $mKEYTitle.Left="20" 
                $mKEYTitle.Anchor="Left,Top" 
        $mKEYTitle.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mKEYTitle) 
         
 
        $mKEYWindows10Key = New-Object System.Windows.Forms.Label ######################### Title KEY Windows 10 entry
                $mKEYWindows10Key.Text="Enter Windos 10 Key" 
                $mKEYWindows10Key.Top="296" 
                $mKEYWindows10Key.Left="45" 
                $mKEYWindows10Key.Anchor="Left,Top" 
        $mKEYWindows10Key.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mKEYWindows10Key) 


                $mKEYKEY = New-Object System.Windows.Forms.TextBox ######################### Variable Windows 10 KEY
                $mKEYKEY.Text="Windows KEY" 
                $mKEYKEY.Top="292" 
                $mKEYKEY.Left="195" 
                $mKEYKEY.Anchor="Left,Top" 
        $mKEYKEY.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mKEYKEY) 


        $mKEYRun = New-Object System.Windows.Forms.Button ######################### Button - Activate Windows
                $mKEYRun.Text="Activate" 
                $mKEYRun.Top="240" 
                $mKEYRun.Left="468" 
                $mKEYRun.Anchor="Left,Top" 
        $mKEYRun.Size = New-Object System.Drawing.Size(200,100) 
        $MyForm.Controls.Add($mKEYRun) 
                $mKEYRun.Add_Click(
                                        {
                                        $computer = gc env:computername
                                        $service = get-wmiObject -query "select * from SoftwareLicensingService" -computername $computer
                                        $service.InstallProductKey($mKEYKEY.Text)
                                        $service.RefreshLicenseStatus()
                                        }
                                 )
#----------------------------------------------------------------------------------------------------------------------------------------

        $mDJTitle = New-Object System.Windows.Forms.Label ######################### Title Domain Join
                $mDJTitle.Text="Domain Join Windows Device" 
                $mDJTitle.Top="383" 
                $mDJTitle.Left="20" 
                $mDJTitle.Anchor="Left,Top" 
        $mDJTitle.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mDJTitle) 
         
 
        $mDJUsername = New-Object System.Windows.Forms.Label ######################### Title Domain Join Admin Username
                $mDJUsername.Text="Admin Username" 
                $mDJUsername.Top="426" 
                $mDJUsername.Left="45" 
                $mDJUsername.Anchor="Left,Top" 
        $mDJUsername.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mDJUsername) 
         
 
        $mDJPW = New-Object System.Windows.Forms.Label ######################### Title Domain Join Admin Password
                $mDJPW.Text="Enter Admin Password" 
                $mDJPW.Top="460" 
                $mDJPW.Left="45" 
                $mDJPW.Anchor="Left,Top" 
        $mDJPW.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mDJPW) 
         
 
        $mDJDomainName = New-Object System.Windows.Forms.Label ######################### Title Domain Join Domain
                $mDJDomainName.Text="Enter Domain Name" 
                $mDJDomainName.Top="492" 
                $mDJDomainName.Left="45" 
                $mDJDomainName.Anchor="Left,Top" 
        $mDJDomainName.Size = New-Object System.Drawing.Size(150,23) 
        $MyForm.Controls.Add($mDJDomainName) 


                $mDJUsername = New-Object System.Windows.Forms.TextBox ######################### Variable Domain Join Username
                $mDJUsername.Text="Username" 
                $mDJUsername.Top="426" 
                $mDJUsername.Left="195" 
                $mDJUsername.Anchor="Left,Top" 
        $mDJUsername.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mDJUsername) 
         
 
        $mDJPassword = New-Object System.Windows.Forms.TextBox ######################### Variable Domain Join Password
                $mDJPassword.Text="Password" 
                $mDJPassword.Top="459" 
                $mDJPassword.Left="195" 
                $mDJPassword.Anchor="Left,Top" 
        $mDJPassword.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mDJPassword) 
         
 
        $mDJDomainName = New-Object System.Windows.Forms.TextBox ######################### Variable Domain Join Domain
                $mDJDomainName.Text="Domain Name" 
                $mDJDomainName.Top="492" 
                $mDJDomainName.Left="195" 
                $mDJDomainName.Anchor="Left,Top" 
        $mDJDomainName.Size = New-Object System.Drawing.Size(200,23) 
        $MyForm.Controls.Add($mDJDomainName) 
        
                 
 
        $mDJRun = New-Object System.Windows.Forms.Button ######################### Button - Domain Join
                $mDJRun.Text="Join" 
                $mDJRun.Top="392" 
                $mDJRun.Left="466" 
                $mDJRun.Anchor="Left,Top" 
        $mDJRun.Size = New-Object System.Drawing.Size(200,100) 
        $MyForm.Controls.Add($mDJRun)
                $mDJRun.Add_Click(
                                        {
                                        $computer = gc env:computername
                                        $secure_pwd = $mDJPassword | ConvertTo-SecureString -AsPlainText -Force
                                        $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $mDJUsername, $secure_pwd
                                        add-computer -computername $computer -domainname $mDJDomainName –credential $cred -restart –force
                                        }
                                 )

#----------------------------------------------------------------------------------------------------------------------------------------

        $mClose = New-Object System.Windows.Forms.Button ######################### Button - Close
                $mClose.Text="Exit" 
                $mClose.Top="550" 
                $mClose.Left="1070" 
                $mClose.Anchor="Left,Top" 
        $mClose.Size = New-Object System.Drawing.Size(100,200) 
        $MyForm.Controls.Add($mClose)
                function OnClick1($Sender, $EventArgs){$myform.close()}
                $mClose.add_click({OnClick1 $this $_})


#----------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------


$MyForm.ShowDialog()
