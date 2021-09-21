################################################################################
#
# puredata-shadylib
#
################################################################################

PUREDATA_SHADYLIB_VERSION = 38b87556e8ce747d2565989bc7bb18df29e1539e 
PUREDATA_SHADYLIB_SITE = https://github.com/sebshader/shadylib.git
PUREDATA_SHADYLIB_SITE_METHOD = git
PUREDATA_SHADYLIB_INSTALL_STAGING = YES
PUREDATA_SHADYLIB_INSTALL_TARGET = YES
PUREDATA_SHADYLIB_DEPENDENCIES = puredata

define PUREDATA_SHADYLIB_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_SHADYLIB_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/shadylib
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/shadylib/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/shadylib/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
