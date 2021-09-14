################################################################################
#
# puredata-holzilib
#
################################################################################
PUREDATA_HOLZILIB_VERSION = 0.2
PUREDATA_HOLZILIB_SOURCE = holzilib$(PUREDATA_HOLZILIB_VERSION).tar_.gz
PUREDATA_HOLZILIB_SITE = http://grh.mur.at/sites/default/files

PUREDATA_HOLZILIB_INSTALL_STAGING = NO
PUREDATA_HOLZILIB_INSTALL_TARGET = YES
PUREDATA_HOLZILIB_DEPENDENCIES = puredata

define PUREDATA_HOLZILIB_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/holzilib
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/holzilib/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/holzilib/
endef


$(eval $(generic-package))
