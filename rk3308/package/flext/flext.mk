################################################################################
#
# flext
#
################################################################################

FLEXT_VERSION = a760d041ebf62a2ba497c0ee8c0138e374aa5124
FLEXT_SITE = https://github.com/grrrr/flext.git
FLEXT_SITE_METHOD = git
FLEXT_AUTORECONF = YES
FLEXT_INSTALL_STAGING = YES
FLEXT_INSTALL_TARGET = YES
FLEXT_DEPENDENCIES = puredata
FLEXT_CONF_OPTS = --with-sdkdir="$(STAGING_DIR)/usr/include/pd" \
		  --with-pdbindir="$(STAGING_DIR)/usr/local/bin/pd"

define FLEXT_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define FLEXT_SHIP_EXTRA
	$(INSTALL) -m 0644  $(@D)/source/flfeatures.h $(STAGING_DIR)/usr/include/flext/
endef
FLEXT_POST_INSTALL_STAGING_HOOKS += FLEXT_SHIP_EXTRA

$(eval $(autotools-package))
