function log_validation(path){

        if((getline _ < path) < 0) {
                print "Log file does not exist" > "/dev/stderr"
                exit 1
        }

        close(path)
}

function check_ip_address(ip){

        x = 0

        for(i = 1; i <= NF; i++) {
                if($i == "from"){
                        x = i + 1
                }
        }

        if($x != ip){
                print "Invalid IP attempting login!"
        }
}


BEGIN {
        ipaddress = "25.55.0.29"
        alert_log = "var/log/auth.log"

        log_validation(alert_log)
}

{
	check_ip_address(ipaddress)
}
