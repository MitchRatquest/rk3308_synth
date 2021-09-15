################################################################################
#
# orca
#
################################################################################

ORCA_VERSION = 50d1c1cc747afc916c43efe4f005754105d81a08
ORCA_SITE = https://github.com/hundredrabbits/Orca-c.git
ORCA_SITE_METHOD = git
ORCA_INSTALL_TARGET = YES
ORCA_DEPENDENCIES = ncurses

define ORCA_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define ORCA_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/orca $(TARGET_DIR)/usr/bin
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/orca
    $(INSTALL) -D -m 0644 $(@D)/examples/*.orca $(TARGET_DIR)/usr/share/orca/
endef

$(eval $(generic-package))
