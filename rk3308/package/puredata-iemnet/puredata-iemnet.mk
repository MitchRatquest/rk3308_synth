################################################################################
#
# puredata-iemnet
#
################################################################################

PUREDATA_IEMNET_VERSION = 88876e81785eb3e5ddbcfad45a691bf11cccd6a0
PUREDATA_IEMNET_SITE = https://git.iem.at/pd/iemnet.git
PUREDATA_IEMNET_SITE_METHOD = git
PUREDATA_IEMNET_INSTALL_STAGING = YES
PUREDATA_IEMNET_INSTALL_TARGET = YES
PUREDATA_IEMNET_DEPENDENCIES = puredata

define PUREDATA_IEMNET_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_IEMNET_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/iemnet
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemnet/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemnet/
	find $(@D) -type f -name "*.so" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemnet/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
