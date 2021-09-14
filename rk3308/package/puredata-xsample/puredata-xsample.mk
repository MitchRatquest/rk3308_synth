################################################################################
#
# puredata-xsample
#
################################################################################

PUREDATA_XSAMPLE_VERSION = 770fd996821fd515f88d459a6a8a07ac05ce130f
PUREDATA_XSAMPLE_SITE = https://github.com/grrrr/xsample.git
PUREDATA_XSAMPLE_SITE_METHOD = git
PUREDATA_XSAMPLE_INSTALL_STAGING = YES
PUREDATA_XSAMPLE_INSTALL_TARGET = YES
PUREDATA_XSAMPLE_DEPENDENCIES = puredata flext

define PUREDATA_XSAMPLE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" CXX="$(TARGET_CXX)" \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I $(STAGING_DIR)/usr/include/flext/" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_XSAMPLE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/xsample
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/xsample/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/xsample/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
	#$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/xsample
	#$(INSTALL) $(@D)/xsample.pd_linux $(TARGET_DIR)/usr/local/lib/pd-externals/xsample/
endef

$(eval $(generic-package))
