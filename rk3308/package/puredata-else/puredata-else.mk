################################################################################
#
# puredata-else
#
################################################################################

PUREDATA_ELSE_VERSION = f3012068a978f5a83237dfcf27e172f2d8b10176
PUREDATA_ELSE_SITE = https://github.com/porres/pd-else.git
PUREDATA_ELSE_SITE_METHOD = git
PUREDATA_ELSE_INSTALL_STAGING = YES
PUREDATA_ELSE_INSTALL_TARGET = YES
PUREDATA_ELSE_DEPENDENCIES = puredata

define PUREDATA_ELSE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_ELSE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/else
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/else/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/else/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
