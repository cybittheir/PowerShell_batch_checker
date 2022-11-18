[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Get-Uptime {
   $os = Get-WmiObject win32_operatingsystem
   $Uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
   return [math]::Round($Uptime.TotalMinutes, 0)
}

$curr_hour=Get-Date -Format "HH"

if ($curr_hour -eq 10) {
	net start w32time
	W32Tm /resync
}

if ($curr_hour -eq 17) {
	net start w32time
	W32Tm /resync
}

$ipaddr=Get-NetIPAddress -IPAddress 192.168.*

if(!$ipaddr) {
	$textip=Get-Content C:\TEMP\tmp_ip.txt
	$compIP=$textip.SubString(38)
} else {
	$compIP=$ipaddr.IPAddress
}

$compName=Get-ComputerInfo LogonServer,CsName,OSUptime

if (!$compName.CsName) {
    $name=$compName.LogonServer
} elseif ($compName.CsName -eq '') {
    $name=$compName.LogonServer
} else {
    $name=$compName.CsName
}

$uptime=[math]::Round($compName.OsUptime.TotalMinutes, 0)

if (!$uptime) {
    $uptime=Get-Uptime
} elseif($uptime -eq ''){
    $uptime=Get-Uptime
}

$proc=Get-Process LedStudio -FileVersionInfo

if (!$proc.ProcessName) {
    $ledProc='1'
} else {
    $ledProc=$cproc
}

$cproc=Get-Process cityscreen-player -FileVersionInfo

if (!$cproc.ProcessName) {
    $cityProc='1'
} else {
    $cityProc=$cproc
}

$cproc=Get-Process trackerboard-http-responder -FileVersionInfo

if (!$cproc.ProcessName) {
    $WFRProc='1'
} else {
    $WFRProc=$cproc
}

$uid_code="some_code"

$curr_time=Get-Date -Format "yyyy-MM-dd HH:mm"

$R = Invoke-WebRequest -URI https://[_url_]/tgmedia/checklink/?mfname=$name"&"mftime=$curr_time"&"mfuptime=$uptime"&"mfip=$compIP"&"led=$ledProc"&"city=$cityProc"&"wfr=$WFRProc"&"UID=$uid_code -UseBasicParsing

$R
