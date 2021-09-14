################################################################################
#
# puredata
#
################################################################################

PUREDATA_VERSION = 0.51-4
PUREDATA_SITE = https://github.com/pure-data/pure-data.git
PUREDATA_SITE_METHOD = git
PUREDATA_INSTALL_STAGING = YES
PUREDATA_INSTALL_TARGET = YES
PUREDATA_AUTORECONF = YES 
PUREDATA_CONF_OPTS += --disable-portaudio --no-recursion --disable-portmidi
PUREDATA_DEPENDENCIES = alsa-utils tcl tk gettext

#ifeq ($(BR2_PACKAGE_JACK2), y)
#PUREDATA_CONF_OPTS += --enable-jack
#else
#PUREDATA_CONF_OPTS += --disable-jack-framework
#endif

#ifeq ($(BR2_PACKAGE_FFTW),y)
#PUREDATA_CONF_OPTS += --enable-fftw
#endif

define PUREDATA_RUN_AUTOGEN
	cd $(@D) &&  PATH=$(HOST_PATH) ./autogen.sh
endef
PUREDATA_PRE_CONFIGURE_HOOKS += PUREDATA_RUN_AUTOGEN

define PUREDATA_BINARY_SYMLINK
        ln -sf /usr/bin/pd $(TARGET_DIR)/usr/lib/pd/bin/pd
endef
PUREDATA_POST_INSTALL_TARGET_HOOKS += PUREDATA_BINARY_SYMLINK

$(eval $(autotools-package))