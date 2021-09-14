################################################################################
#
# puredata-cyclone
#
################################################################################
PUREDATA_CYCLONE_VERSION = b194c97afc07be69ff58f568b08744f4727850b7
PUREDATA_CYCLONE_SITE = https://github.com/porres/pd-cyclone.git
PUREDATA_CYCLONE_SITE_METHOD = git

PUREDATA_CYCLONE_INSTALL_STAGING = YES
PUREDATA_CYCLONE_INSTALL_TARGET = YES
PUREDATA_CYCLONE_DEPENDENCIES = puredata
PUREDATA_CYCLONE_OPTS = PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
			PDDIR="$(STAGING_DIR)/usr/lib/pd" \
			PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
			DESTDIR=""

define PUREDATA_CYCLONE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		$(PUREDATA_CYCLONE_OPTS) \
		-C $(@D) all
endef

define PUREDATA_CYCLONE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/cyclone
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/cyclone/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/cyclone/

#	$(TARGET_MAKE_ENV) $(PUREDATA_CYCLONE_OPTS) $(MAKE) \
#		DESTDIR="$(TARGET_DIR)" install -C $(@D)
endef

$(eval $(generic-package))
