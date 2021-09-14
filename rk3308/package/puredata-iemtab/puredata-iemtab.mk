################################################################################
#
# puredata-iemtab
#
################################################################################

PUREDATA_IEMTAB_VERSION = 8fc9ecade9ba682ea6b95777266f29ae38a3e80b
PUREDATA_IEMTAB_SITE = https://git.iem.at/pd/iem_tab.git
PUREDATA_IEMTAB_SITE_METHOD = git
PUREDATA_IEMTAB_INSTALL_STAGING = YES
PUREDATA_IEMTAB_INSTALL_TARGET = YES
PUREDATA_IEMTAB_DEPENDENCIES = puredata

define PUREDATA_IEMTAB_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_IEMTAB_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/iemtab
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemtab/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemtab/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
