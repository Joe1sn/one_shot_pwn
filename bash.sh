#pwn环境一键搭建
# Author: Create by Joe1sn
# Description:
	#0-系统基础
	#1-换源
	#2-安装python2/3 python-pip  git vim gdb
	#3-安装pwntools+python换源
	#4-安装peda-gdb pwndbg
	#5-安装拓展工具 pwngdb
	#6-安装sublime_text_3
#0-系统基础
release_num=$(lsb_release -r --short)
code_name=$(lsb_release -c --short)
hw_arch=$(uname -m)
path=$(pwd)

echo "[-]release_num> $release_num"
echo "[-]code_name> $code_name"
echo "[-]hardware Architecture> $hw_arch"
echo "[-]cmdpath> $path"

if [ $code_name != 'xenial' ] || [ $code_name != 'bionic' ]; then
	echo "[+]Sorry, This is system is not support"
	exit
fi

#1-换源
#均使用清华源
echo "[?]Change the sources file? (y/n) "
read Xstep
if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
	echo "[?]In China's mainland? (y/n) "
	read Xstep
	if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then	
		echo "[*]BackUp sources.list"
		sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
		echo "[*]Wipe sources.list"
		sudo rm /etc/apt/sources.list
		echo "[*]Generate new sources.list"
		sudo touch /etc/apt/sources.list

		if [ $release_num = '16.04' ]; then
			sudo echo "# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list

			# 预发布软件源，不建议启用
			sudo echo "# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list
		elif [ $release_num = '18.04' ]; then
			echo "[-]USing version>> 18.04"
			sudo echo "# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list

			# 预发布软件源，不建议启用
			sudo echo "# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list
		elif [ $release_num = '20.04' ]; then
			echo "[-]USing version>> 20.04"
			sudo echo "# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list

			# 预发布软件源，不建议启用
			sudo echo "# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list
			sudo echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list
		else
			sudo echo "[-]Can't support this version > $release_num"
			sudo echo "[+]More can find in https://mirror.tuna.tsinghua.edu.cn/"	
			exit
		fi
	fi
fi
sudo echo "[*]Writting is done"

#2-安装python2/3 python-pip  git vim gdb
echo "[?]Install vim git python python-pip gdb? (y/n) "
read Xstep
if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
	if [ $release_num = '16.04' ] || [ $release_num = '18.04' ]; then
		echo "[*]Install softwares"
		sudo apt update
		sudo apt install vim git python python-pip gdb
		echo "[*]Softwares installed"
	elif [ $release_num = '20.04' ]; then
		echo "[*]Install softwares"
		sudo apt update
		sudo apt install vim git python3 python3-pip gdb
		echo "[*]Softwares installed"
	fi
fi

#3-安装pwntools
echo "[?]Install pwntools? (y/n) "
read Xstep
if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
	echo "[?]In China's mainland? (y/n) "
	read Xstep
	if [ $Xstep = "y" ] || [ $Xstep = "Y" ] && [ $release_num != '20.04' ]; then
		echo "[*]Install pwntools"
		#python换源
		sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
		sudo pip install pip -U
		sudo pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
		#安装pwntools
		sudo pip install pwntools
	else 
		sudo pip install pwntools
	fi
	echo "[*]Done"
fi


#4-安装peda-gdb pwndbg
echo "[?]Install peda-gdb pwndbg gef? (y/n) "
read Xstep
if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
	sudo touch ~/.gdbinit
	echo "[?]In China's mainland? (y/n) "
	read Xstep
	if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
		# 安装peda-gdb
		echo "[*]Install gdb-peda"
		sudo git clone https://gitee.com/Wizzy/peda ~/peda
		sudo echo "source ~/peda/peda.py" >> ~/.gdbinit
		echo "[*]Peda done"
		# 安装pwndbg
		echo "[*]Install pwndbg"
		sudo git clone https://gitee.com/Wizzy/pwndbg
		cd pwndbg/
		sudo ./setup.sh
		sudo cd ..
		echo "[*]pwndbg done"
		# 安装gef
		echo "[*]Install gef"
		sudo wget -q -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/master/gef.py
		sudo echo source ~/.gdbinit-gef.py >> ~/.gdbinit
		echo "[*]Gef done"
	else
		# 安装peda-gdb
		echo "[*]Install gdb-peda"
		sudo git clone https://github.com/longld/peda.git ~/peda
		sudo echo "source ~/peda/peda.py" >> ~/.gdbinit
		echo "[*]Peda done"
		# 安装pwndbg
		echo "[*]Install pwndbg"
		sudo git clone https://github.com/pwndbg/pwndbg
		cd pwndbg/
		sudo ./setup.sh
		sudo cd ..
		echo "[*]pwndbg done"
	fi
fi

#5-安装拓展工具 pwngdb 和 libcsearcher
echo "[?]Install pwngdb? (y/n) "
read Xstep
if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
	echo "[?]In China's mainland? (y/n) "
	read Xstep
	if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then
		echo "[*]Install pwngdb, it's not pwndbg"
		sudo git clone https://gitee.com/jshuang/Pwngdb
		sudo echo "source ~/Pwngdb/pwngdb.py" >> ~/.gdbinit
		sudo echo "source ~/Pwngdb/angelheap/gdbinit.py" >> ~/.gdbinit
		sudo echo "" >> ~/.gdbinit
		sudo echo "define hook-run" >> ~/.gdbinit
		sudo echo "python" >> ~/.gdbinit
		sudo echo "import angelheap" >> ~/.gdbinit
		sudo echo "angelheap.init_angelheap()" >> ~/.gdbinit
		sudo echo "end" >> ~/.gdbinit
		sudo echo "end" >> ~/.gdbinit
		echo "[*]Pwndbg is done"

		echo "[+]You can change the gdb setting file"
		echo "	 In ~/.gdbinit"

	else
		echo "[*]Install pwngdb, it's not pwndbg"
		sudo git clone https://github.com/scwuaptx/Pwngdb.git

		sudo echo "source ~/Pwngdb/pwngdb.py" >> ~/.gdbinit
		sudo echo "source ~/Pwngdb/angelheap/gdbinit.py" >> ~/.gdbinit
		sudo echo "" >> ~/.gdbinit
		sudo echo "define hook-run" >> ~/.gdbinit
		sudo echo "python" >> ~/.gdbinit
		sudo echo "import angelheap" >> ~/.gdbinit
		sudo echo "angelheap.init_angelheap()" >> ~/.gdbinit
		sudo echo "end" >> ~/.gdbinit
		sudo echo "end" >> ~/.gdbinit
		echo "[*]Pwndbg is done"

		echo "[+]You can change the gdb setting file"
		echo "	 In ~/.gdbinit"
	fi
fi

#6-安装sublime_text_3
echo "[*]Now install sublime_text_3"
echo "[?]In China's mainland? (y/n) "
read Xstep
if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then	
	echo "[+]Download the file through the link below"
	echo "https://wws.lanzoui.com/ivFyIivw98d"
	echo "[+]Please remove file to folder > "
	echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
	echo "[?]Install sublime_text_3 now? (y/n) "
	read Xstep
	if [ $Xstep = "y" ] || [ $Xstep = "Y" ]; then	
		unzip file.zip
		sudo tar -xvvf sublime_text_3_build_3211_x64.tar.bz2
		sudo mv sublime_text_3 /opt
		sudo cp /opt/sublime_text_3/sublime_text.desktop /usr/share/applications
		sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime_text
		sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl
	fi

else
	echo "[*]Install 'sublime_text_3'"
	echo "[+]If this is too slow,please using proxy or VPN"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text
fi
echo "[*]sublime usage: subl <filename>"

echo "[*]All settal done"
echo "[*]enjoy your Pwn journey"