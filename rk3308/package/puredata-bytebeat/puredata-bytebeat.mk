################################################################################
#
# puredata-bytebeat
#
################################################################################

PUREDATA_BYTEBEAT_VERSION = c6f11e4b4666981089d45c29803b0df2031aca66
PUREDATA_BYTEBEAT_SITE = https://github.com/fluxly/bytebeat-pd
PUREDATA_BYTEBEAT_SITE_METHOD = git
PUREDATA_BYTEBEAT_INSTALL_STAGING = NO
PUREDATA_BYTEBEAT_INSTALL_TARGET = YES
PUREDATA_BYTEBEAT_DEPENDENCIES = puredata

define PUREDATA_BYTEBEAT_BUILD_CMDS
	cd $(@D) && rm -rf bytebeat~.pd_linux
	$(CC) -I "$(STAGING_DIR)/usr/include/pd" \
		-mcpu=cortex-a35 -rdynamic -rshared \
		-fPIC -ffast-math -O3 -lm -lc \
		bytebeat~.c -o bytebeat~.pd_linux
#		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
#		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
#		-C $(@D)
endef

define PUREDATA_BYTEBEAT_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/bytebeat
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bytebeat/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/bytebeat/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
