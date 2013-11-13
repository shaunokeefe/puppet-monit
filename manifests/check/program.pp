# Attempt to create a program check template
# Define: monit::check::program
# Creates a monit program check,
#
# Parameters:
#   name     - the name of this resource will be the program name
#   path	- the path to the program includes program exe file
#   customlines - lets you inject custom lines into the monitrc snippet, just pass an array, and it will appear in the configuration file
#
# Actions:
#   The following actions gets taken by this defined type:
#    - creates /etc/monit/conf.d/namevar.monitrc as root:root mode 0400 based on _template_
#
# Requires:
#   - Package["monit"]
#
# Sample usage:
# (start code)
#   monit::check::program{"myshellscript":
#     path	  => "/home/ubuntu/testshellscript",
#     customlines => ["if status !=0 then alert"]
#   }
# (end)

define monit::check::program($ensure=present, $program=$name,
                             $path="$path",
                             $alert=[],
                             $alert_types=[],
                             $customlines="") {
	file {"/etc/monit/conf.d/$name.monitrc":
		ensure  => $ensure,
		owner   => "root",
		group   => "root",
		mode    => 0400,
		content => template("monit/check_program.monitrc.erb"),
		notify  => Service["monit"],
	}
}

