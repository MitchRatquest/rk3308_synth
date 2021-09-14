################################################################################
#
# puredata-boids
#
################################################################################
PUREDATA_BOIDS_VERSION = d2fbd80b88ca0a88ddae05f3bacf8eb81965ea7b
PUREDATA_BOIDS_SITE = https://salsa.debian.org/multimedia-team/pd/pd-boids.git
PUREDATA_BOIDS_SITE_METHOD = git

PUREDATA_BOIDS_INSTALL_STAGING = YES
PUREDATA_BOIDS_INSTALL_TARGET = YES
PUREDATA_BOIDS_DEPENDENCIES = puredata

define PUREDATA_BOIDS_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PD_INCLUDE="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef
# DONT DO THE STRIPPING, REMOVE PD_INCLUDE IN MAKEFILE
define PUREDATA_BOIDS_INSTALL_TARGET_CMDS
	echo $(NAME)
	echo $(_NAME)
	echo $(@D)
	echo $(@NAME)
	basename $(@D)
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/boids
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/boids/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/boids/
#	$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
