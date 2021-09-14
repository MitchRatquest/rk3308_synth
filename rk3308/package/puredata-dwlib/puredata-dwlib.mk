################################################################################
#
# puredata-dwlib
#
################################################################################

PUREDATA_DWLIB_VERSION = 807a62a53dea3b5ca95f93cfb7cd0d18d92d1b75
PUREDATA_DWLIB_SITE = https://git.iem.at/pd/dw_lib.git
PUREDATA_DWLIB_SITE_METHOD = git
PUREDATA_DWLIB_INSTALL_STAGING = YES
PUREDATA_DWLIB_INSTALL_TARGET = YES
PUREDATA_DWLIB_DEPENDENCIES = puredata

define PUREDATA_DWLIB_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_DWLIB_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/dwlib
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/dwlib/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/dwlib/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
