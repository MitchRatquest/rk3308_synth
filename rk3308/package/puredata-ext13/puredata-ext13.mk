################################################################################
#
# puredata-ext13
#
################################################################################

PUREDATA_EXT13_VERSION = 0.17.1
PUREDATA_EXT13_SOURCE = pd-ext13_$(PUREDATA_EXT13_VERSION).orig.tar.gz
PUREDATA_EXT13_SITE = http://deb.debian.org/debian/pool/main/p/pd-ext13
PUREDATA_EXT13_INSTALL_STAGING = NO
PUREDATA_EXT13_INSTALL_TARGET = YES
PUREDATA_EXT13_DEPENDENCIES = puredata

define PUREDATA_EXT13_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef


define PUREDATA_EXT13_INSTALL_TARGET_CMDS
# $(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/ext13
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/ext13/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/ext13/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
