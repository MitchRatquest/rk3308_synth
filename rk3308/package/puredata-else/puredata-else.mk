################################################################################
#
# puredata-else
#
################################################################################

PUREDATA_ELSE_VERSION = c9491f3837a8f961364a905c2490bd13d3081f25
PUREDATA_ELSE_SITE = https://github.com/porres/pd-else.git
PUREDATA_ELSE_SITE_METHOD = git
PUREDATA_ELSE_INSTALL_STAGING = YES
PUREDATA_ELSE_INSTALL_TARGET = YES
PUREDATA_ELSE_DEPENDENCIES = puredata

define PUREDATA_ELSE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_ELSE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/else
	find $(@D) -type f -name "*.pd" -print -0 | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/else/
	find $(@D) -type f -name "*.pd_linux" -print -0 | xargs -I{} $(INSTALL) -m 0755 \
		 {} $(TARGET_DIR)/usr/local/lib/pd-externals/else/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
