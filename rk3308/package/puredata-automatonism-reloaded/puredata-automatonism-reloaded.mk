################################################################################
#
# puredata-automatonism-reloaded
#
################################################################################

PUREDATA_AUTOMATONISM_RELOADED_VERSION = b43445cb82b2f852cde122773fbf32d4cf6f6af4
PUREDATA_AUTOMATONISM_RELOADED_SITE = https://github.com/jyg/automatonism-reloaded.git
PUREDATA_AUTOMATONISM_RELOADED_SITE_METHOD = git
PUREDATA_AUTOMATONISM_RELOADED_INSTALL_STAGING = YES
PUREDATA_AUTOMATONISM_RELOADED_INSTALL_TARGET = YES
PUREDATA_AUTOMATONISM_RELOADED_DEPENDENCIES = puredata

define PUREDATA_AUTOMATONISM_RELOADED_BUILD_CMDS
	true
endef

define PUREDATA_AUTOMATONISM_RELOADED_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/automatonism-reloaded
	cp -a $(@D)/*  $(TARGET_DIR)/usr/local/lib/pd-externals/automatonism-reloaded/
endef

$(eval $(generic-package))
