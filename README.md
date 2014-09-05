CoinDaemon
==========

Installation of coin daemon using shell script <br />
This is shell script for installing coin daemon in Ubuntu server. <br />
Requirements : <br />
OS : Ubuntu 14.04 LTS (Tested) // Support for every *Nix based system <br />
User :  Root <br />
Coin : some basic requirements of coins like coin name, algo name, git source, hostname, RPC Port <br />

Use following guide for easy installation of coin daemon <br />
1. Download/Clone coin.sh : git clone https://github.com/jagdishjaipur11/CoinDaemon.git <br />
2. cd CoinDaemon <br />
3. File permission : chmod +x coin.sh <br />
4. Run file : ./coin.sh OR sh coin.sh 

<h4>Now you can Use Script for Coin Daemon installation using browser</h4> <br />
<h5>Requirements :</h5> <br />
1. Enable CGI Mode in Apache Server <br />
2. Update Apache conf file ( Use this link : http://askubuntu.com/questions/403067/cgi-bin-not-work ) <br />
3. Provide sudoer permission to www-data user <br />
4. www-data user must be member of root group <br />
5. /root directory will be writable for group <br />
6. use default directory for cgi ( In ubuntu : /usr/lib/cgi-bin/ ) <br />
7. Make sure you have atleast 1 GB RAM in your system <br />

Use following guide for easy installation of coin daemon <br />
1. Download/Clone coin.sh : git clone https://github.com/jagdishjaipur11/CoinDaemon.git <br />
2. copy to CGI default directory ( In ubuntu : /usr/lib/cgi-bin/ ) <br />
3. go to browser and type : ( http://localhost/cgi-bin/coin.sh ) 
4. Enter required information and enjoy ( Note : Script may take around 10 min to install coin daemon , it totally depends on your Internet Connection and System Configuration )


