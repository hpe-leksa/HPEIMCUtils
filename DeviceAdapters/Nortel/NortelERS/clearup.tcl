            
#**************************************************************************
# Identification:clearup.tcl
# Purpose:       try to recover a prompt, then exit
#**************************************************************************

proc clearup {} {
    global ERROR_RESULT
    global enable_prompt
    global exec_prompt
    global config_prompt
		
	if { $ERROR_RESULT == "true" } {
		set loop true
		while { $loop == "true" } {
			send "\r"
			expect {
				$enable_prompt {
					send "logout\r"
					set loop false
				} $exec_prompt {
					send "logout\r"
					set loop false
				} $config_prompt {
					send "end\r"
				} -re "(Bad|denied)" {
					send "\r"
				}
			}
		}
	}
}