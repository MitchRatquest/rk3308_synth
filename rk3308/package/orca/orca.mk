################################################################################
#
# orca
#
################################################################################

ORCA_VERSION = e6a9a30ba09f71e18ec85aa613fb0ebdd6c9bec6
ORCA_SITE = https://github.com/hundredrabbits/Orca-c.git
ORCA_SITE_METHOD = git
ORCA_INSTALL_TARGET = YES
ORCA_DEPENDENCIES = ncurses

define ORCA_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		-C $(@D) all
endef

define ORCA_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/orca $(TARGET_DIR)/usr/bin
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/orca
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/orca/basics
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/orca/benchmarks
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/orca/misc
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/orca/setups
    $(INSTALL) -D -m 0644 $(@D)/examples/basics/* $(TARGET_DIR)/usr/share/orca/basics
    $(INSTALL) -D -m 0644 $(@D)/examples/benchmarks/* $(TARGET_DIR)/usr/share/orca/benchmarks
    $(INSTALL) -D -m 0644 $(@D)/examples/misc/* $(TARGET_DIR)/usr/share/orca/misc
    $(INSTALL) -D -m 0644 $(@D)/examples/setups/* $(TARGET_DIR)/usr/share/orca/setups
endef

$(eval $(generic-package))
