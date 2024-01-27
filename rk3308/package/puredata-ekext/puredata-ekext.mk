################################################################################
#
# puredata-ekext
#
################################################################################

PUREDATA_EKEXT_VERSION = 0.1.8
PUREDATA_EKEXT_SOURCE = ekext-$(PUREDATA_EKEXT_VERSION).tar.gz
PUREDATA_EKEXT_SITE = http://sharktracks.co.uk/puredata
PUREDATA_EKEXT_INSTALL_STAGING = NO
PUREDATA_EKEXT_INSTALL_TARGET = YES
PUREDATA_EKEXT_DEPENDENCIES = puredata

define PUREDATA_EKEXT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC=$(TARGET_CC) LD=$(TARGET_LD) \
		CFLAGS+="-mtune=cortex-a35" \
		CPU="aarch64" \
		PD_PATH="$(STAGING_DIR)" \
		PD_INCLUDE="$(STAGING_DIR)/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		prefix="$(TARGET_DIR)/usr/local" \
		-C $(@D) all
endef

define PUREDATA_EKEXT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/ekext
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/ekext/
	find $(@D) -maxdepth 1 -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/ekext/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
