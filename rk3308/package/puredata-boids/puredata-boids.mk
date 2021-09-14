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
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_BOIDS_INSTALL_TARGET_CMDS
	$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
