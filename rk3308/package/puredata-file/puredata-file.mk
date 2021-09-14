################################################################################
#
# puredata-file
#
################################################################################

PUREDATA_FILE_VERSION = 595ebf3a51b77c41ddc3d9c3a14e8b5f536382a0
PUREDATA_FILE_SITE = https://git.iem.at/pd/file.git
PUREDATA_FILE_SITE_METHOD = git
PUREDATA_FILE_INSTALL_STAGING = YES
PUREDATA_FILE_INSTALL_TARGET = YES
PUREDATA_FILE_DEPENDENCIES = puredata

define PUREDATA_FILE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_FILE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/file
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/file/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/file/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
