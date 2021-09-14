################################################################################
#
# puredata-adaptive
#
################################################################################
PUREDATA_ADAPTIVE_VERSION = 0.1
PUREDATA_ADAPTIVE_SOURCE = adaptive$(PUREDATA_ADAPTIVE_VERSION).tar_.gz
PUREDATA_ADAPTIVE_SITE = http://grh.mur.at/sites/default/files

PUREDATA_ADAPTIVE_INSTALL_STAGING = NO
PUREDATA_ADAPTIVE_INSTALL_TARGET = YES
PUREDATA_ADAPTIVE_DEPENDENCIES = puredata

define PUREDATA_ADAPTIVE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PD_PATH="$(STAGING_DIR)/usr/lib/pd" \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" -C $(@D)/src
endef

define PUREDATA_ADAPTIVE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/adaptive
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/adaptive/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/adaptive/
endef


$(eval $(generic-package))
