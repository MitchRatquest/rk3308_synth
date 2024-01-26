################################################################################
#
# puredata-beatpipe
#
################################################################################

PUREDATA_BEATPIPE_VERSION = 0.1
PUREDATA_BEATPIPE_SOURCE = pd-beatpipe_$(PUREDATA_BEATPIPE_VERSION).orig.tar.gz
PUREDATA_BEATPIPE_SITE = http://deb.debian.org/debian/pool/main/p/pd-beatpipe
PUREDATA_BEATPIPE_INSTALL_STAGING = NO
PUREDATA_BEATPIPE_INSTALL_TARGET = YES
PUREDATA_BEATPIPE_DEPENDENCIES = puredata

define PUREDATA_BEATPIPE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef


define PUREDATA_BEATPIPE_INSTALL_TARGET_CMDS
# $(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/beatpipe
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/beatpipe/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/beatpipe/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
