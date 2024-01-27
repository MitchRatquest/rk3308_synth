################################################################################
#
# puredata-creb
#
################################################################################

PUREDATA_CREB_VERSION = 5bb3f6c08865961e1d28b933dc235e0f656fa5eb
PUREDATA_CREB_SITE = https://github.com/electrickery/pd-creb.git
PUREDATA_CREB_SITE_METHOD = git
PUREDATA_CREB_INSTALL_STAGING = NO
PUREDATA_CREB_INSTALL_TARGET = YES
PUREDATA_CREB_DEPENDENCIES = puredata

define PUREDATA_CREB_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC=$(TARGET_CC) LD=$(TARGET_LD) \
		CXX="$(TARGET_CXX)" CPPFLAGS="$(TARGET_CPPFLAGS)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef


define PUREDATA_CREB_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/creb
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/creb/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/creb/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
