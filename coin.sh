#! /bin/bash
#######################################################################################################
# Coind Generation Script File 
# Created By : Jagdish Jat
# Created For : Linux World
# # Tested on : ubuntu 14.04 LTS Server
#
####################################################################################################### 

############################ WelCome Information For End User #########################################
dialog --title 'Welcome Message !!' --backtitle 'Jagdish Jat' \
 --msgbox 'Hello, Friends !
 Welcomes you on the field of CryptoCurrency. A Secure way of Trading And Mining' 10 80

########### Some Constant 
LOG_FILE="`mktemp`"
touch $LOG_FILE
chmod 777 $LOG_FILE

## INSTALLATION OF REQUIRED PACKAGES
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get install libssl-dev libdb-dev libdb++-dev libqrencode-dev qt4-qmake libqtgui4 libqt4-dev 
sudo apt-get install libminiupnpc-dev libboost-all-dev build-essential git 

############################# Coin Basic Information ################################################

########### Coin Name #######
dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter your Coin name please" 8 60 2> /tmp/coinname
sel=$?
case $sel in
  0) coin=`cat /tmp/coinname`
  	while [ -z "$coin" ];
  	do
		dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
		" --inputbox "Coin Name not be Empty !!, please Re-Enter " 8 60 2> /tmp/coinname
		sel=$?
		case $sel in
		0) coin=`cat /tmp/coinname`
		1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
		esac
	done
	
	d=d
	coind=$coin$d ;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

######Algorithm Name ########
dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter your Algorithim Name please like Scrypt, sha256d" 8 60 2> /tmp/algoname
sel=$?
case $sel in
  0) algo=`cat /tmp/algoname`;;
  	while [ -z "$algo" ];
  	do
  		dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
		" --inputbox "Algorithim name not be Empty !!. Please Re-Enter like Scrypt, sha256d" 8 60 2> /tmp/algoname
		sel=$?
		case $sel in
		 0) algo=`cat /tmp/algoname`;;
		 1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
  	done
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

######################## Source Installation  #######################################################
dialog --title "Source Code Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter your Source Code Address like git://github.com/coin.git " 8 60 2>/tmp/sourcecode
sel=$?
case $sel in
  0) source=`cat /tmp/sourcecode`
  	while [ -z "$algo" ];
  	do
  		dialog --title "Source Code Information - To take input from you" --backtitle "Jagdish Jat\
		" --inputbox "Source Code Address Not be Empty !!. Please Re-Enter like git://github.com/coin.git " 8 60 2>/tmp/sourcecode
		sel=$?
		case $sel in
  		0) source=`cat /tmp/sourcecode`
  		1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
  	done
	
	#Grab the latest version of Coind using Git
	cd ~
	sudo git clone $source $coin $LOG_FILE >> $LOG_FILE 2>&1 
	if [ $? -ne 0 ];then
		echo "ERROR: Failed to get file from GitHub, Please check logfile $LOG_FILE" 1>&2
		exit 1
	fi

	#compile the coind
	# Change to src folder
	cd ~
	cd $coin/src/

	#Compile coind
	sudo make -f makefile.unix USE_UPNP=- >> $LOG_FILE 2>&1
		if [ $? -ne 0 ]; then
			echo "ERROR: Failed to configure $coin Daemon. Please check logfile $LOG_FILE" 1>&2
			exit 1
		fi

	#Copy to System path
	sudo cp -rf $coind /usr/bin
	cd ~

	#Make confige file 
	sudo $coind getaccountaddress "" 2> /tmp/cname
	file=`grep /  /tmp/cname`;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

############################### Configuration File  #################################################
#### FOr RPC PORT #################
dialog --title "RPC PORT Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter RPC Port for Coin Daemon " 8 60 2> /tmp/rname
sel=$?
case $sel in
  0) rpcport=`cat /tmp/rname`
	user=rpc
	rpcuser=$coin$user
	rpcpassword=Nx3dgd84753qhdfgh5478UnvVKT;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

#### For Hostname ###
dialog --title "HostName Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter Hostname for Coin Daemon please like localhost,domain.com" 8 60 2> /tmp/hname
sel=$?
case $sel in
  0) hostname=`cat /tmp/hname`
	#enter details in coind config file
sudo echo "
## $coin.conf -- configuration file for $coin
##
rpcuser=$rpcuser
rpcpassword=$rpcpassword
server=1
daemon=1
listen=1
gen=0
rpcport=$rpcport
rpcallow=*
rpcconnect=$hostname" > $file

	#get address from coindi
	cd ~
	sudo $coind
	sudo $coind getaccountaddress "" > /tmp/address
	wallet=`cat /tmp/address`;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

###############################  COIN Installation SUMMARY  ######################################################
dialog --title 'Summary' --backtitle 'Jagdish Jat' --msgbox "Coin Name = $coin
Coind Daemon = $coind
Algorithm = $algo
Source Address = $source  
Config File = $file
Hostname = $hostname 
RpcPort = $rpcport
Wallet Address = $wallet" 14 80
