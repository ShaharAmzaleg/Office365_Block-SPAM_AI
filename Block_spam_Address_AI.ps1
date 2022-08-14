$month=get-date -uFormat %B_%Y



##################please define the following variables####################
$path="D:\BlockSpamAddresses\"
$SpamMailBox="spam@domain.com"
$from="NoReply@domain.com"
$To="admin@domain.com"
$SmtpServer="SmtpServer@domain.com"

$AdminName = <exchange admin user name>
$Pass = <exchange admin Secure password path>
$SpamCount=3 #choose how much spam mail will report until the address will enter to the black list
#################################################


$Log_Path=$path+"Logs\BlockSpamAddresses-"+$month+".log"
$Date=get-date
$dateStr = $Date.ToString("dd-MM-yyyy")

Add-Content -Path $Log_Path -Value "-----------------Start - $Date----------------"





$MSOLCred = New-Object -TypeName System.Management.Automation.PSCredential $AdminName, (Get-Content $Pass | ConvertTo-SecureString)

Connect-ExchangeOnline -Credential $MSOLCred

$latestmessage=Get-MessageTrace -RecipientAddress $SpamMailBox -StartDate (get-date).AddDays(-1).ToString("MM-dd-yyyy") -EndDate (get-date).ToString("MM-dd-yyyy")

$subjects=($latestmessage| select Subject).Subject

$latestmessage=$latestmessage| select Subject,SenderAddress
$listofaddress= @()
$latestmessage | foreach-object {
$subject=$null
$SenderAddress=$null
$subject=$_.Subject.Split('|') | select -f 4 | select -l 1
$SenderAddress=$_.SenderAddress

$listaddress = "" | Select subject,SenderAddress
$listaddress.subject=$subject
$listaddress.SenderAddress=$SenderAddress
$listofaddress += $listaddress
}

############### optional - add domain address to exceptions, these domain will no enter to the black list 
#$spamaddress=$listofaddress| ? {$_.Subject -notlike "*@domain1.com" -and $_.Subject -notlike "*@domain2.com"}
$spamaddress=$listofaddress

$spamaddress_log=$path+"SpamAddress-DB.log"

if ($spamaddress){
 $totalspamaddress=$null
  $spamaddress | foreach-object {
    $addr=$null
    $sender=$null
	$addr=$_.subject
	$sender=$_.SenderAddress
	
    Add-Content -Path $spamaddress_log -Value $addr
    Add-Content -Path $Log_Path -Value "(INFO) New Address Report as a Spam, Address: $addr, report by: $sender."                            
                                } 
  $totalspamaddress=gc $spamaddress_log
  
  $spamaddress | foreach-object {
    $address=$null
	$addrsubject=$null
	$checkifexist=$null
    $address=$_
	$addrsubject=$address.subject
    
    if (($totalspamaddress | ? {$_ -eq $addrsubject}).count -gt $SpamCount-1){
	
	
	$checkifexist=(get-HostedContentFilterPolicy -Identity Default |select -ExpandProperty BlockedSenders).Sender | ? {$_.Address -eq $addrsubject}
	if($checkifexist){write-host "address exist";$totalspamaddress | select-string -pattern $addrsubject -notmatch | sc $spamaddress_log}else{
	
    
    set-HostedContentFilterPolicy -Identity Default -BlockedSenders @{add=$addrsubject}
    Add-Content -Path $Log_Path -Value "(INFO) The address: $addr added to AntiSpam Policy"
	$totalspamaddress | select-string -pattern $addrsubject -notmatch | sc $spamaddress_log
	write-host "The address: $addr added to AntiSpam Policy"
	
	$messageParameters = @{
Subject = "New Address Added to Microsoft 365 Defender AntiSpam Policy"
Body = "The Address is: $addrsubject .<br><br>Link to AntiSpam Policy: https://security.microsoft.com/antispam<br><br> FYI."
From = $from
To = $To
SmtpServer = $SmtpServer
Encoding = "utf8"
}
	
	Send-MailMessage @messageParameters -BodyAsHtml
	
    }
  
  }
}}




$ENDDate=get-date
Add-Content -Path $Log_Path -Value "-----------------END - $ENDDate----------------"

