################################################################################
#
# puredata-gee
#
################################################################################
PUREDATA_GGEE_VERSION = 95777602dff8ae074b7a47a9db7fecda5d94281d
PUREDATA_GGEE_SITE = https://github.com/pd-externals/ggee.git
PUREDATA_GGEE_SITE_METHOD = git

PUREDATA_GGEE_INSTALL_STAGING = NO
PUREDATA_GGEE_INSTALL_TARGET = YES
PUREDATA_GGEE_DEPENDENCIES = puredata

define PUREDATA_GGEE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		-C $(@D)
#	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
#		PD_PATH="$(STAGING_DIR)/usr/lib/pd" \
#		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" -C $(@D)/net
#	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
#		PD_PATH="$(STAGING_DIR)/usr/lib/pd" -C $(@D)/cmos
#	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
#		PD_PATH="$(STAGING_DIR)/usr/lib/pd" -C $(@D)/osc
endef

define PUREDATA_GGEE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/ggee
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/ggee/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/ggee/
endef


$(eval $(generic-package))
