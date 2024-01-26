################################################################################
#
# puredata-bassemu
#
################################################################################

PUREDATA_BASSEMU_VERSION = 0.3
PUREDATA_BASSEMU_SOURCE = pd-bassemu_$(PUREDATA_BASSEMU_VERSION).orig.tar.gz
PUREDATA_BASSEMU_SITE = https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/pd-bassemu/0.3-11
PUREDATA_BASSEMU_INSTALL_STAGING = NO
PUREDATA_BASSEMU_INSTALL_TARGET = YES
PUREDATA_BASSEMU_DEPENDENCIES = puredata

define PUREDATA_BASSEMU_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		-C $(@D)
endef


define PUREDATA_BASSEMU_INSTALL_TARGET_CMDS
# $(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/bassemu
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bassemu/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bassemu/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
