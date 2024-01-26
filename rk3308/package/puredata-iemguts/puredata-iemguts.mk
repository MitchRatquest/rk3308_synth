################################################################################
#
# puredata-iemguts
#
################################################################################

PUREDATA_IEMGUTS_VERSION = 48fc16a046ba513ce13d83a4100eb22eac6480cd
PUREDATA_IEMGUTS_SITE = https://git.iem.at/pd/iemguts.git
PUREDATA_IEMGUTS_SITE_METHOD = git
PUREDATA_IEMGUTS_INSTALL_STAGING = YES
PUREDATA_IEMGUTS_INSTALL_TARGET = YES
PUREDATA_IEMGUTS_DEPENDENCIES = puredata

define PUREDATA_IEMGUTS_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_IEMGUTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/iemguts
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemguts/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemguts/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
