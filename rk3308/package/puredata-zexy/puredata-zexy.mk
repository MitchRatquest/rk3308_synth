################################################################################
#
# puredata-zexy
#
################################################################################

PUREDATA_ZEXY_VERSION = 98d4a190cfb0d662255e7c493ffb9c500b8680b3
PUREDATA_ZEXY_SITE = https://git.iem.at/pd/zexy.git
PUREDATA_ZEXY_SITE_METHOD = git
PUREDATA_ZEXY_INSTALL_STAGING = NO
PUREDATA_ZEXY_INSTALL_TARGET = YES
PUREDATA_ZEXY_DEPENDENCIES = puredata

define PUREDATA_ZEXY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_ZEXY_INSTALL_TARGET_CMDS
# $(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/zexy
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/zexy/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/zexy/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
