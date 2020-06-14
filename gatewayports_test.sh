SSHD_CONFIG="/etc/ssh/sshd_config"

CONFIG_LINE="$(grep 'GatewayPorts' $SSHD_CONFIG)"
CONFIG_LINE_OPTION="$(echo $CONFIG_LINE | grep 'yes' )"

if [ -z "$CONFIG_LINE" ]; then
	echo "'GatewayPorts' configuration not existing in '$SSHD_CONFIG'"
	echo 'GatewayPorts yes' >> $SSHD_CONFIG
	echo 'Added:'
	echo "$(tail -3 $SSHD_CONFIG)"
elif [ -z "$CONFIG_LINE_OPTION" ]; then
	echo "'GatewayPorts' configuration not set in '$SSHD_CONFIG'"
	sed -i.bkp 's/GatewayPorts\s\+no/GatewayPorts yes/' $SSHD_CONFIG
	echo 'Set:'
	echo "$(grep -n -A1 'GatewayPorts yes' $SSHD_CONFIG)"
else
	echo "'GatewayPorts yes' is already set"
fi
