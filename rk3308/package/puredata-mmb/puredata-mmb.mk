################################################################################
#
# puredata-mmb
#
################################################################################

PUREDATA_MMB_VERSION = 89fa73f7b52d8d21b433c063eb49fe5a8989c20f
PUREDATA_MMB_SITE = https://github.com/dotmmb/mmb.git
PUREDATA_MMB_SITE_METHOD = git
PUREDATA_MMB_INSTALL_STAGING = YES
PUREDATA_MMB_INSTALL_TARGET = YES
PUREDATA_MMB_DEPENDENCIES = puredata

#define PUREDATA_MMB_BUILD_CMDS
#	$(TARGET_MAKE_ENV) $(MAKE) \
#		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
#		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
#		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
#		-C $(@D)
#endef

define PUREDATA_MMB_INSTALL_TARGET_CMDS
	#$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/mmb
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/mmb/
	#find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
	#	{} $(TARGET_DIR)/usr/local/lib/pd-externals/mmb/
endef

$(eval $(generic-package))
