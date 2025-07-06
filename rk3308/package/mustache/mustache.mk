################################################################################
#
# mustache
#
################################################################################
MUSTACHE_VERSION = v4.1
MUSTACHE_SITE = $(call github,kainjow,Mustache,$(MUSTACHE_VERSION))
MUSTACHE_INSTALL_STAGING = YES
MUSTACHE_INSTALL_TARGET = NO

define MUSTACHE_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include
	cp -dpfr $(@D)/*hpp $(STAGING_DIR)/usr/include
endef

$(eval $(generic-package))
