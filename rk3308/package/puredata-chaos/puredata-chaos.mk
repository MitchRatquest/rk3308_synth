################################################################################
#
# puredata-chaos
#
################################################################################

PUREDATA_CHAOS_VERSION = 0.2
#PUREDATA_CHAOS_SITE = https://sourceforge.net/projects/pure-data/files/libraries/chaos/chaos-$(PUREDATA_CHAOS_VERSION).tar.gz
PUREDATA_CHAOS_SITE = https://sourceforge.net/project/pure-data/chaos-$(PUREDATA_CHAOS_VERSION).tar.gz
PUREDATA_CHAOS_INSTALL_STAGING = NO
PUREDATA_CHAOS_INSTALL_TARGET = YES
PUREDATA_CHAOS_DEPENDENCIES = puredata

define PUREDATA_CHAOS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		PDLIBDIR="$(TARGET_DIR)/usr/local/lib/pd-externals" \
		PDBINDIR="$(TARGET_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef


define PUREDATA_CHAOS_INSTALL_TARGET_CMDS
# $(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/chaos
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/chaos/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/chaos/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
