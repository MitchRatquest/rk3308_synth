################################################################################
#
# puredata-bsaylor
#
################################################################################

PUREDATA_BSAYLOR_VERSION = 4e64813e347defa7c7b51c944e9cdbe2e903bd5d
PUREDATA_BSAYLOR_SITE = https://github.com/pd-externals/bsaylor.git
PUREDATA_BSAYLOR_SITE_METHOD = git
PUREDATA_BSAYLOR_GIT_SUBMODULES = YES
PUREDATA_BSAYLOR_INSTALL_STAGING = YES
PUREDATA_BSAYLOR_INSTALL_TARGET = YES
PUREDATA_BSAYLOR_DEPENDENCIES = puredata

define PUREDATA_BSAYLOR_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		build.arch="$(BR2_ARCH)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_BSAYLOR_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/bsaylor
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bsaylor/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bsaylor/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
