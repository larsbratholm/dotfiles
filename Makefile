SHELL=/bin/bash
all: symlink_clean folders symlink bin_folder packages vim

x: all symlink.x_clean bin.x_folder i3 packages.x install_conda install.x gnome_terminal_settings

folders:
	mkdir -p ~/opt ~/dev ~/tmp ~/.ssh ~/.config/nvim

i3:
	mkdir -p ~/.i3
	ln -sf `pwd`/i3config ~/.i3/config
	ln -sf `pwd`/i3status ~/.i3status.conf

symlink:
	ln -sf `pwd`/vimrc ~/.config/nvim/init.vim
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/ssh_config ~/.ssh/config

symlink_clean: symlink_clean_bin
	rm -f .config/nvim/init.vim ~/.gitconfig  ~/.bashrc ~/.bash_aliases ~/.bash_profile ~/.inputrc ~/.ssh/config

symlink.x_clean: symlink_clean_bin.x
	rm -f ~/.i3status ~/.i3/config

packages:
	sudo apt update
	sudo apt install -y $(shell cat packages.apt)

packages.x:
	sudo apt install -y $(shell cat packages.apt.x)

bin_folder:
	mkdir -p ~/bin
	# Don't overwrite anything
	for x in bin/*; do \
		if [ ! -f ~/$$x  ]; then\
			ln -s `pwd`/$$x ~/$$x;\
		fi; \
	done

bin.x_folder:
	mkdir -p ~/bin.x
	# Don't overwrite anything
	for x in bin.x/*; do \
		if [ ! -f ~/$$x  ]; then\
			ln -s `pwd`/$$x ~/$$x;\
		fi; \
	done

symlink_clean_bin:
	for x in bin/*; do \
		rm -f ~/$$x;\
	done

symlink_clean_bin.x:
	for x in bin.x/*; do \
		rm -f ~/$$x;\
	done

install_conda:
	setup/conda_install.sh
	setup/conda_essentials.sh

install.x:
	setup.x/setup_dropbox.sh
	setup.x/setup_slack.sh
	setup.x/setup_zoom.sh
	setup.x/setup_gitkraken.sh

vim:
	setup/download_nvim.sh
	setup/vim_install.sh
	setup/vim_update.sh

gnome_terminal_settings:
	dconf load /org/gnome/terminal/ < gnome_terminal_settings.txt
