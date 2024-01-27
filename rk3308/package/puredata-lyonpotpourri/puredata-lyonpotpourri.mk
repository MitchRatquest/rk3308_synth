################################################################################
#
# puredata-lyonpotpourri
#
################################################################################

PUREDATA_LYONPOTPOURRI_VERSION = a9074810fdb9d4d0fcbfc172833cbaa9655b96fc
PUREDATA_LYONPOTPOURRI_SITE = https://github.com/ericlyon/pd-lyonpotpourri.git
PUREDATA_LYONPOTPOURRI_SITE_METHOD = git
PUREDATA_LYONPOTPOURRI_INSTALL_STAGING = YES
PUREDATA_LYONPOTPOURRI_INSTALL_TARGET = YES
PUREDATA_LYONPOTPOURRI_DEPENDENCIES = puredata

define PUREDATA_LYONPOTPOURRI_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_LYONPOTPOURRI_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/lyonpotpourri
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/lyonpotpourri/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/lyonpotpourri/
	find $(@D) -type f -name "*.so" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/lyonpotpourri/
endef

$(eval $(generic-package))
