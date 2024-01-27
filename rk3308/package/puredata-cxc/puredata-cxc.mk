################################################################################
#
# puredata-cxc
#
################################################################################

PUREDATA_CXC_VERSION = 0.5.2
PUREDATA_CXC_SOURCE = pd-cxc_$(PUREDATA_CXC_VERSION).orig.tar.gz
PUREDATA_CXC_SITE = http://deb.debian.org/debian/pool/main/p/pd-cxc
PUREDATA_CXC_INSTALL_STAGING = NO
PUREDATA_CXC_INSTALL_TARGET = YES
PUREDATA_CXC_DEPENDENCIES = puredata

define PUREDATA_CXC_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC=$(TARGET_CC) LD=$(TARGET_LD) \
		PD_INCLUDE="$(STAGING_DIR)/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		prefix="$(TARGET_DIR)/usr/local" \
		-C $(@D)
endef


define PUREDATA_CXC_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/cxc
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/cxc/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/cxc/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
