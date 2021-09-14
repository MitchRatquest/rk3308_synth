################################################################################
#
# puredata-iemmatrix
#
################################################################################

PUREDATA_IEMMATRIX_VERSION = 5d33ae46d710e9f28715f86fc8937c59380d9a76
PUREDATA_IEMMATRIX_SITE = https://git.iem.at/pd/iemmatrix.git
PUREDATA_IEMMATRIX_SITE_METHOD = git
PUREDATA_IEMMATRIX_AUTORECONF = YES
PUREDATA_IEMMATRIX_INSTALL_STAGING = YES
PUREDATA_IEMMATRIX_INSTALL_TARGET = YES
PUREDATA_IEMMATRIX_DEPENDENCIES = puredata fftw libsndfile

define PUREDATA_IEMMATRIX_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_IEMMATRIX_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/iemmatrix
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemmatrix/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/iemmatrix/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
endef

$(eval $(generic-package))
