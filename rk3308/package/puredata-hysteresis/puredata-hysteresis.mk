################################################################################
#
# puredata-hysteresis
#
################################################################################

PUREDATA_HYSTERESIS_VERSION = 1.0
PUREDATA_HYSTERESIS_SOURCE = 1623591405751-hysteresis-$(PUREDATA_HYSTERESIS_VERSION).zip
PUREDATA_HYSTERESIS_SITE = https://forum.pdpatchrepo.info/uploads/files
PUREDATA_HYSTERESIS_INSTALL_STAGING = NO
PUREDATA_HYSTERESIS_INSTALL_TARGET = YES
PUREDATA_HYSTERESIS_DEPENDENCIES = puredata

define PUREDATA_HYSTERESIS_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_HYSTERESIS_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/hysteresis
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/hysteresis/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/hysteresis/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
