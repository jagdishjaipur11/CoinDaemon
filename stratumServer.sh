#! /bin/bash
############################ MPOS  MESSAGE BOX ###################################################
dialog --title 'Welcome to Stratum Installation !!' --backtitle 'Jagdish Jat' --msgbox 'Hello, Friends ! 
 Welcomes you to for Stratum Installation' 10 80
########### Stratum Download  #######
dialog --title "Stratum Information" --backtitle "Jagdish\
" --inputbox "Enter your directory  name please" 8 60 2>dname
sel=$?
case $sel in
  0) dir=`cat dname`
        cd /var/www/$dir
	sudo apt-get install python-twisted python-mysqldb python-dev python-setuptools python-memcache python-simplejson python-pylibmc
	easy_install -U distribute

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
