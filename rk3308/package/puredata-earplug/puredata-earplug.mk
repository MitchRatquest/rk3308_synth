################################################################################
#
# puredata-earplug
#
################################################################################

PUREDATA_EARPLUG_VERSION = d7c9bb8528c7fc583fb0d2e9181aa510af87f165
PUREDATA_EARPLUG_SITE = https://github.com/pd-externals/earplug.git
PUREDATA_EARPLUG_SITE_METHOD = git
PUREDATA_EARPLUG_INSTALL_STAGING = NO
PUREDATA_EARPLUG_INSTALL_TARGET = YES
PUREDATA_EARPLUG_DEPENDENCIES = puredata

define PUREDATA_EARPLUG_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef


define PUREDATA_EARPLUG_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/earplug
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/earplug/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/earplug/
	find $(@D) -type f -name "*.py" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/earplug/
endef

$(eval $(generic-package))
