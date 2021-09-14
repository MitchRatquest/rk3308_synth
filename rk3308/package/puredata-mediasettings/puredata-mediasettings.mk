################################################################################
#
# puredata-mediasettings
#
################################################################################

PUREDATA_MEDIASETTINGS_VERSION = b58396b8fcf653e94e24a0c3a14f01f1fa3d8f98
PUREDATA_MEDIASETTINGS_SITE = https://git.iem.at/pd/mediasettings.git
PUREDATA_MEDIASETTINGS_SITE_METHOD = git
PUREDATA_MEDIASETTINGS_INSTALL_STAGING = YES
PUREDATA_MEDIASETTINGS_INSTALL_TARGET = YES
PUREDATA_MEDIASETTINGS_DEPENDENCIES = puredata alsa-lib

define PUREDATA_MEDIASETTINGS_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_MEDIASETTINGS_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/mediasettings
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/mediasettings/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/mediasettings/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
