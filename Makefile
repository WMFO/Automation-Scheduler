#Makefile for Automation Scheduler
#Suggested usage: git pull
#		  sudo make all
#                 sudo make install
#
#Compile without installing: make all

INSTALLDIR=/opt/wmfo/scheduler
OWNER = root
MOD = 700
FILE = scheduler
SCRIPT = generate_log.sh
CREDS = credentials.cpp
CREDSMOD = 600

.PHONY: all install 

all: $(FILE)
	@chown $(OWNER) $(CREDS)
	@chmod $(CREDSMOD) $(CREDS)

$(FILE): $(FILE).cpp $(CREDS)
	@g++ *.cpp -lmysqlpp -o $@ -Wall -Wextra -Werror
	@chown $(OWNER) $@
	@chmod $(MOD) $@

install: $(INSTALLDIR)/$(FILE)
	@mkdir -p $(INSTALLDIR)/logs
	@cp $(SCRIPT) $(INSTALLDIR)/logs

$(INSTALLDIR)/$(FILE): $(FILE)
	@mkdir -p $(INSTALLDIR)
	@cp $< $@
	@chown $(OWNER) $@
	@chmod $(MOD) $@
