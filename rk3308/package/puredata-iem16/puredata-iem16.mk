################################################################################
#
# puredata-iem16
#
################################################################################

PUREDATA_IEM16_VERSION = b52662e94221beef8cd1ebc468f8ab28bc017ed3
PUREDATA_IEM16_SITE = https://git.iem.at/pd/iem16.git
PUREDATA_IEM16_SITE_METHOD = git
PUREDATA_IEM16_INSTALL_STAGING = YES
PUREDATA_IEM16_INSTALL_TARGET = YES
PUREDATA_IEM16_DEPENDENCIES = puredata

define PUREDATA_IEM16_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_IEM16_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/iem16
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iem16/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iem16/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
