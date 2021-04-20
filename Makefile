SHELL=/bin/bash
all: symlink_clean folders symlink bin_folder packages install vim

x: all symlink.x_clean bin.x_folder i3 packages.x install.x

folders:
	mkdir -p ~/opt ~/dev ~/tmp ~/.vim ~/.ssh

i3:
	mkdir -p ~/.i3
	ln -sf `pwd`/i3config ~/.i3/config
	ln -sf `pwd`/i3status ~/.i3status.conf

symlink:
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/ssh_config ~/.ssh/config

symlink_clean: symlink_clean_bin
	rm -f ~/.vimrc ~/.gitconfig  ~/.bashrc ~/.bash_aliases ~/.bash_profile ~/.inputrc ~/.ssh/config

symlink.x_clean: symlink_clean_bin.x
	rm -f ~/.i3status ~/.i3/config

packages:
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

install:
	setup/conda_install.sh
	setup/conda_essentials.sh

install.x:
	setup.x/setup_dropbox.sh
	setup.x/setup_mendeley.sh
	setup.x/setup_slack.sh
	setup.x/setup_zoom.sh
	setup.x/setup_gitkraken.sh

vim:
	./vim_snippets.sh
	./vim_install.sh
	./vim_update.sh
