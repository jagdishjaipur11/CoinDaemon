#! /bin/bash
#This program is free software: you can redistribute it and/or modify it
#under the terms of the GNU General Public License as published by the
#Free Software Foundation, either version 2 of the License, or (at your option)
#any later version.
#
#This program is distributed in the hope that it will be useful, but WITHOUT ANY
#WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#See the GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License along with this program.
#If not, see http://www.gnu.org/licenses/.

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
 Welcomes you on the field of CryptoCurrency.' 10 80

########### Some Constant 
LOG_FILE="`mktemp`"
touch $LOG_FILE
chmod 777 $LOG_FILE

## INSTALLATION OF REQUIRED PACKAGES
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get install libssl-dev libdb-dev libdb++-dev libqrencode-dev qt4-qmake libqtgui4 libqt4-dev  -y >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
	echo "ERROR: Failed to install required packages, Please check logfile $LOG_FILE" 1>&2
	exit 1
fi

sudo apt-get install libminiupnpc-dev libboost-all-dev build-essential git -y >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
	echo "ERROR: Failed to install required packages, Please check logfile $LOG_FILE" 1>&2
	exit 1
fi

############################# Coin Basic Information ################################################

########### Coin Name #######
dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter your Coin name  : " 8 60 2> /tmp/coinname
sel=$?
case $sel in
  0) coin=`cat /tmp/coinname`
        while [ -z "$coin" ];do
                dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
        " --inputbox "Coin Name not be Empty !!, Re-Enter for Installation" 8 60 2> /tmp/coinname
	sel=$?
	case $sel in
		0) coin=`cat /tmp/coinname`;;
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
  0) algo=`cat /tmp/algoname`
  	while [ -z "$algo" ];do
  	dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
	" --inputbox "Algorithim name not be Empty !!. Please Re-Enter like Scrypt, sha256d" 8 60 2> /tmp/algoname
	sel=$?
	case $sel in
		0) algo=`cat /tmp/algoname`;;
		1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
  	esac
  	done;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

######################## Source Installation  #######################################################
dialog --title "Source Code Information - To take input from you" --backtitle "Jagdish Jat\
" --inputbox "Enter your Source Code Address like git://github.com/coin.git " 8 60 2>/tmp/sourcecode
sel=$?
case $sel in
  0) source=`cat /tmp/sourcecode`
  	while [ -z "$algo" ];do
  	dialog --title "Source Code Information - To take input from you" --backtitle "Jagdish Jat\
	" --inputbox "Source Code Address Not be Empty !!. Please Re-Enter like git://github.com/coin.git " 8 60 2>/tmp/sourcecode
	sel=$?
	case $sel in
  		0) source=`cat /tmp/sourcecode`;;
  		1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
  	esac
  	done
	
	#Grab the latest version of Coind using Git
	cd ~
	git clone $source $coin >> $LOG_FILE 2>&1 
	if [ $? -ne 0 ];then
		echo "ERROR: Failed to get file from GitHub, Please check logfile $LOG_FILE" 1>&2
		exit 1
	fi
	#compile the coind
	# Change to src folder
	cd ~
	cd $coin/src/

	#Compile coind
	make -f makefile.unix USE_UPNP=- >> $LOG_FILE 2>&1
		if [ $? -ne 0 ]; then
			echo "ERROR: Failed to configure $coin Daemon. Please check logfile $LOG_FILE" 1>&2
			exit 1
		fi

	#Copy to System path
	cp -rf $coind /usr/bin
	cd ~

	#Make confige file 
	$coind getaccountaddress "" 2> /tmp/cname
	file=`grep /  /tmp/cname`
	echo $file;;
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
  	while [ -z "$algo" ];do
  	dialog --title "RPC PORT Information - To take input from you" --backtitle "Jagdish Jat\
	" --inputbox "RPC Port Not be Empty !!. Please Re-Enter like 9332 " 8 60 2>/tmp/rname
	sel=$?
	case $sel in
  		0) source=`cat /tmp/rname`;;
  		1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
  	esac
  	done
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
  	while [ -z "$algo" ];do
  	dialog --title "HostName Information - To take input from you" --backtitle "Jagdish Jat\
	" --inputbox "Hostname Not be Empty !!. Please Re-Enter like localhost, domain.com" 8 60 2> /tmp/hname
	sel=$?
	case $sel in
  		0) hostname=`cat /tmp/hname`;;
  		1) echo "Cancel is Press" ;;
  		255) echo "[ESCAPE] key pressed" ;;
  	esac
  	done
  	
	#enter details in coind config file
echo "
## $coin.conf -- configuration file for $coin
##
rpcuser=$rpcuser
rpcpassword=$rpcpassword
server=1
daemon=1
listen=1
gen=0
rpcport=$rpcport
rpcallowip=*
rpcconnect=$hostname" > $file

	#get address from coindi
	cd ~
	$coind
	sleep 30
	$coind getaccountaddress ""  >> $LOG_FILE 2>&1  
	if [ $? -ne 0 ]; then
		echo "ERROR: Failed to start coind, Please check logfile $LOG_FILE" 1>&2
		exit 1
	
	else
    	$coind getaccountaddress "" > /tmp/address
	wallet=`cat /tmp/address`
	fi ;;
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
