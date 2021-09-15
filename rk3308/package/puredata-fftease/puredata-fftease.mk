################################################################################
#
# puredata-fftease
#
################################################################################

PUREDATA_FFTEASE_VERSION = 552912e9c557dae7e2cec5f5d6c5bacbd6f6e075
PUREDATA_FFTEASE_SITE = https://github.com/ericlyon/pd-fftease.git
PUREDATA_FFTEASE_SITE_METHOD = git
PUREDATA_FFTEASE_INSTALL_STAGING = YES
PUREDATA_FFTEASE_INSTALL_TARGET = YES
PUREDATA_FFTEASE_DEPENDENCIES = puredata

define PUREDATA_FFTEASE_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDLIBDIR="" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_FFTEASE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/fftease
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/fftease/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/fftease/
	find $(@D) -type -f -name "*.so" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/fftease/
endef

$(eval $(generic-package))
