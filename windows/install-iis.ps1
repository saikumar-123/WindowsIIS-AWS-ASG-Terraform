iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Host "Installing IIS..."
Import-Module ServerManager
$features = @(
   "Web-WebServer",
   "Web-Static-Content",
   "Web-Common-Http",
   "Web-Default-Doc",
   "Web-Dir-Browsing",
   "Web-Http-Errors",
   "Web-Http-Logging",
   "Web-Http-Redirect",
   "Web-Url-Auth",
   "Web-Security",
   "Web-IP-Security",
   "Web-Stat-Compression",
   "Web-Filtering",
   "Web-Scripting-Tools",
   "Web-CGI,Web-Performance",
   "Web-Health",
   "Web-App-Dev",
   "Web-Asp-Net45",
   "Web-Net-Ext45",
   "Web-ISAPI-Ext",
   "Web-ISAPI-Filter",
   "Web-Mgmt-Console",
   "Web-Mgmt-Tools",
   "Web-Mgmt-Service"
)
Add-WindowsFeature $features -Verbose


choco install -y webdeploy

choco install -y ms-reportviewer2015

choco install -y urlrewrite