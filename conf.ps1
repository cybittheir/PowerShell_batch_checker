$uid_code="some_code"

$url="192.168.14.35/tgmedia/checklink/"

$R = Invoke-WebRequest -URI https://$url"?"mfname=$name -UseBasicParsing

