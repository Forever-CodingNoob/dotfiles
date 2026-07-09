#!/usr/bin/env bash

connection_name=$(nmcli -t -g type,name connection \
	| grep -Po '^vpn:\K.*' \
	| sed 's/\\:/:/g' | fzf
)

username=$(nmcli -g vpn.user-name connection show "$connection_name")

password=$(sudo nmcli -t -g vpn.secrets --show-secrets conn show "$connection_name" | grep -Po '(^|, )password *= *\K[^,]*')
restore_secrets() {
	sudo nmcli connection modify "$connection_name" vpn.secrets "password=$password" >/dev/null
}
trap restore_secrets EXIT

eval "$(nmcli -t -g vpn.data connection show "$connection_name" \
	| grep -Po '(^|[ ,])(protocol|gateway|csd_wrapper|authgroup|useragent)\ =\ [^,]*' \
	| sed 's/ //g')"
eval "$(
    printf '%s\npush\n' "$password" \
    | openconnect --authenticate "$gateway" \
                    -u "$username" \
                    --protocol="$protocol" \
                    --useragent="$useragent" \
                    --authgroup="$authgroup" \
                    --csd-wrapper="$csd_wrapper" \
                    --no-external-auth \
                    --passwd-on-stdin
    )"

echo "COOKIE length: ${#COOKIE}" >&2
echo "HOST: $HOST" >&2
echo "FINGERPRINT: $FINGERPRINT" >&2

sudo nmcli connection modify "$connection_name" vpn.secrets "cookie=$COOKIE,gateway=$HOST,gwcert=$FINGERPRINT"
sudo nmcli connection up "$connection_name"
