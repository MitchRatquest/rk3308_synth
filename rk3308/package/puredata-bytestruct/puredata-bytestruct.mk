################################################################################
#
# puredata-bytestruct
#
################################################################################

PUREDATA_BYTESTRUCT_VERSION = e1acc54ab592e0181cc0b54f5125f4d0e19206c4
PUREDATA_BYTESTRUCT_SITE = https://git.iem.at/pd/bytestruct.git
PUREDATA_BYTESTRUCT_SITE_METHOD = git
PUREDATA_BYTESTRUCT_INSTALL_STAGING = YES
PUREDATA_BYTESTRUCT_INSTALL_TARGET = YES
PUREDATA_BYTESTRUCT_DEPENDENCIES = puredata

define PUREDATA_BYTESTRUCT_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_BYTESTRUCT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/bytestruct
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bytestruct/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bytestruct/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
