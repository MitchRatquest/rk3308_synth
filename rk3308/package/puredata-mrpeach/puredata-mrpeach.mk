################################################################################
#
# puredata-mrpeach
#
################################################################################

PUREDATA_MRPEACH_VERSION = f61377574a1d331608bf0dae66407e1745c059ce
PUREDATA_MRPEACH_SITE = https://git.puredata.info/cgit/svn2git/libraries/mrpeach.git
PUREDATA_MRPEACH_SITE_METHOD = git
PUREDATA_MRPEACH_INSTALL_STAGING = NO
PUREDATA_MRPEACH_INSTALL_TARGET = YES
PUREDATA_MRPEACH_DEPENDENCIES = puredata

define PUREDATA_MRPEACH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		PD_PATH="$(STAGING_DIR)/usr/lib/pd" -C $(@D) all
	$(TARGET_MAKE_ENV) $(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) \
		PD_PATH="$(STAGING_DIR)/usr/lib/pd" \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" -C $(@D)/net
	$(TARGET_MAKE_ENV) $(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		PD_PATH="$(STAGING_DIR)/usr/lib/pd" -C $(@D)/cmos
	$(TARGET_MAKE_ENV) $(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		PD_PATH="$(STAGING_DIR)/usr/lib/pd" -C $(@D)/osc
endef

define PUREDATA_MRPEACH_INSTALL_TARGET_CMDS
	#$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/mrpeach
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/mrpeach/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/mrpeach/
endef


$(eval $(generic-package))
