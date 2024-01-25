################################################################################
#
# puredata-comport
#
################################################################################

PUREDATA_COMPORT_VERSION = 1450e73c4c4e7ec08de5b667d013abdbe071e72f
PUREDATA_COMPORT_SITE = https://git.iem.at/pd/comport.git
PUREDATA_COMPORT_SITE_METHOD = git
PUREDATA_COMPORT_INSTALL_STAGING = NO
PUREDATA_COMPORT_INSTALL_TARGET = YES
PUREDATA_COMPORT_DEPENDENCIES = puredata

define PUREDATA_COMPORT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef


define PUREDATA_COMPORT_INSTALL_TARGET_CMDS
# $(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/comport
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/comport/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/comport/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
