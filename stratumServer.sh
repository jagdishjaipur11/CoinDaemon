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
############################ MPOS  MESSAGE BOX ###################################################
dialog --title 'Welcome to Stratum Installation !!' --backtitle 'Jagdish Jat' --msgbox 'Hello, Friends ! 
 Welcomes you to for Stratum Installation' 10 80

### Install required packages ##
sudo apt-get install python-twisted python-mysqldb python-dev python-setuptools python-memcache python-simplejson python-pylibmc 
easy_install -U distribute >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
echo "ERROR: Failed to install required packages, Please check logfile $LOG_FILE" 1>&2
exit 1
fi
	

########### Stratum Download  #######
dialog --title "Stratum Information" --backtitle "Jagdish\
" --inputbox "Enter your directory  name where you want to install stratum " 8 60 2>dname
sel=$?
case $sel in
  0) dir=`cat dname`
  	 while [ -z "$coin" ];do
                dialog --title "Wallet Information - To take input from you" --backtitle "Jagdish Jat\
		" --inputbox "Coin Name not be Empty !!, please Re-Enter " 8 60 2> /tmp/coinname
		sel=$?
		case $sel in
  			0) dir=`cat dname`;;
  			1) echo "Cancel is Press" ;;
    			255) echo "[ESCAPE] key pressed" ;;
		esac
	done
	
	#Change directory where startum will be installed
        cd /var/www/$dir
	#sudo apt-get install python-twisted python-mysqldb python-dev python-setuptools python-memcache python-simplejson python-pylibmc
	#easy_install -U distribute

	#Download Stratum-mining package 
	sudo git clone https://github.com/ahmedbodi/stratum-mining.git
	sudo git clone https://github.com/ahmedbodi/stratum.git

        #Installation
	cd stratum-mining
	git submodule init
	git submodule update
	cd externals/stratum
	sudo python setup.py install
	
	#Configuration 
	cp stratum-mining/conf/config_sample.py stratum-mining/conf/config.py

	########################## Configure wallet information ##################
	sudo sed -i " 12 s|set_valid_addresss_in_config\!|$wallet|" stratum-mining/conf/config.py
	sudo sed -i " 14 s/localhost/$hostname/" stratum-mining/conf/config.py
	sudo sed -i " 15 s/8332/$rpcport/" stratum-mining/conf/config.py
	sudo sed -i " 16 s/user/$rpcuser/" stratum-mining/conf/config.py
	sudo sed -i " 17 s/somepassword/$rpcpassword/" stratum-mining/conf/config.py
	sudo sed -i " 25 s/scrypt/$algo/" stratum-mining/conf/config.py
	#sed -i 's/COINDAEMON_Reward =*/COINDAEMON_Reward = 'POW'/' stratum-mining/conf/config.py
	#sed -i 's/COINDAEMON_SHA256_TX =*/COINDAEMON_SHA256_TX = 'no'/' stratum-mining/conf/config.py
	###################### Hostname Information ##############################
	sudo sed -i " 70 s/localhost/$hostname/" stratum-mining/conf/config.py;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac

############################# PORT INFORMATION ############
dialog --title "Stratum Information" --backtitle "BitNorm Organization\
" --inputbox "Enter socket or port number please" 8 60 2>socname
sel=$?
case $sel in
  0) socket=`cat socname`
        sudo sed -i " 76 s/3333/$socket/" stratum-mining/conf/config.py
	################# DATABASE INFORMATION ##################################
	# We use default database server mysql if you want to change than just chnage it (Switch and Case)
	#sed -i " 90 s/mysql/mysql/" stratum-mining/conf/config.py
	sudo sed -i " 102 s/localhost/$hostname/" stratum-mining/conf/config.py
	sudo sed -i " 103 s/pooldb/$coin/" stratum-mining/conf/config.py
	sudo sed -i " 104 s/pooldb/$dbuser/" stratum-mining/conf/config.py
	sudo sed -i " 105 s/\*\*empty\*\*/$dbpass/" stratum-mining/conf/config.py ;;

  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac
################### POOL Difficulty ######################################
dialog --title "Stratum Installation" --backtitle "BitNorm Organization\
" --inputbox "Enter Intial Difficuly for Pool please" 8 60 2>poolt
sel=$?
case $sel in
  0) ptarget=`cat poolt`
       sudo sed -i " 145 s/32/$ptarget/" stratum-mining/conf/config.py

	#################### Solution Block Hash #################################
	sudo sed -i " 170 s/True/True/" stratum-mining/conf/config.py
	sudo sed -i " 196 s/stratum\_/stratum\_$coin/" stratum-mining/conf/config.py;;
  1) echo "Cancel is Press" ;;
  255) echo "[ESCAPE] key pressed" ;;
esac
