################################################################################
#
# puredata-aconnect
#
################################################################################
PUREDATA_ACONNECT_VERSION = 6d1c740e538c3b5d746e128ad06d90cea4884620
PUREDATA_ACONNECT_SITE = https://git.iem.at/pd/aconnect.git
PUREDATA_ACONNECT_SITE_METHOD = git

PUREDATA_ACONNECT_INSTALL_STAGING = YES
PUREDATA_ACONNECT_INSTALL_TARGET = YES
PUREDATA_ACONNECT_DEPENDENCIES = puredata

define PUREDATA_ACONNECT_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_ACONNECT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/aconnect
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/aconnect/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/aconnect/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
