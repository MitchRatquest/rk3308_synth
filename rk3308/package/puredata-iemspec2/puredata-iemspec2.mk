################################################################################
#
# puredata-iemspec2
#
################################################################################

PUREDATA_IEMSPEC2_VERSION = 8c52c9ace8f82e7470e4c4eaa45e29565d76dd3c
PUREDATA_IEMSPEC2_SITE = https://git.iem.at/pd/iem_spec2.git
PUREDATA_IEMSPEC2_SITE_METHOD = git
PUREDATA_IEMSPEC2_INSTALL_STAGING = YES
PUREDATA_IEMSPEC2_INSTALL_TARGET = YES
PUREDATA_IEMSPEC2_DEPENDENCIES = puredata

define PUREDATA_IEMSPEC2_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_IEMSPEC2_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/iemspec2
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemspec2/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemspec2/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
