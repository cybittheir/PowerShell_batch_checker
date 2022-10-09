net time /setsntp
w32tm /query /peers
net stop w32time
net start w32time
w32time /resync /nowait
EOF