################################################################################
#
# websocketd
#
################################################################################

WEBSOCKETD_VERSION = v0.4.1
WEBSOCKETD_SITE = $(call github,joewalnes,websocketd,$(WEBSOCKETD_VERSION))

#WEBSOCKETD_INSTALL_STAGING = YES
#WEBSOCKETD_INSTALL_TARGET = YES
#WEBSOCKETD_AUTORECONF = YES 
#WEBSOCKETD_CONF_OPTS = --disable-portaudio --disable-portmidi --no-recursion

#WEBSOCKETD_DEPENDENCIES = alsa-utils tcl tk

#define WEBSOCKETD_RUN_AUTOGEN
#	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
#endef
#WEBSOCKETD_PRE_CONFIGURE_HOOKS += WEBSOCKETD_RUN_AUTOGEN

#define WEBSOCKETD_BINARY_SYMLINK
#        ln -sf /usr/bin/pd $(TARGET_DIR)/usr/lib/pd/bin/pd
#endef
#WEBSOCKETD_POST_INSTALL_TARGET_HOOKS += WEBSOCKETD_BINARY_SYMLINK

$(eval $(golang-package))