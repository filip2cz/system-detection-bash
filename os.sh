if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -d /Haiku ]; then
	# Haiku OS
	OS="Haiku"
elif [ $(ps -ef|grep -c com.termux ) -gt 0 ]; then
    # termux detection https://www.reddit.com/r/termux/comments/co46qw/how_to_detect_in_a_bash_script_that_im_in_termux/
    OS="termux"
    VER="unknown"
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    OS=SuSE
    VER=$(cat /etc/SuSe-release)
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    OS=RedHat
    VER=$(cat /etc/redhat-release)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Check if the variable is set and not empty
if [ -n "$OS" ]; then
    
    # Construct the file path
    SCRIPT_PATH="./${OS}.sh"

    # Check if it is a regular file (does not need executable flag)
    if [ -f "$SCRIPT_PATH" ]; then
        # Execute the script via sh
        sh "$SCRIPT_PATH"
    else
        # Print specific message if the file is missing
        echo "no file for $OS"
    fi
fi