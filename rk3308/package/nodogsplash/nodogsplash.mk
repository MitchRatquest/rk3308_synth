################################################################################
#
# nodogsplash
#
################################################################################

NODOGSPLASH_VERSION = a65459edeebc5c9544ae9944d41258e4e23b0ca0
NODOGSPLASH_SITE = https://github.com/nodogsplash/nodogsplash.git
NODOGSPLASH_SITE_METHOD = git
NODOGSPLASH_INSTALL_TARGET = YES
NODOGSPLASH_DEPENDENCIES = libmicrohttpd

define NODOGSPLASH_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define NODOGSPLASH_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/nodogsplash $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 0755 $(@D)/ndsctl $(TARGET_DIR)/usr/bin
    $(INSTALL) -d $(TARGET_DIR)/etc/nodogsplash
    $(INSTALL) -D -m 0755 $(@D)/resources/nodogsplash.conf $(TARGET_DIR)/etc/nodogsplash/
    #$(INSTALL) -D -m 0644 $(@D)/examples/*.nodogsplash $(TARGET_DIR)/usr/share/nodogsplash/
endef

$(eval $(generic-package))
