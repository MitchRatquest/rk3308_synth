################################################################################
#
# puredata-py4pd
#
################################################################################

PUREDATA_PY4PD_VERSION = c968fbc15af94c965c0d09786bc4640cd640d357
PUREDATA_PY4PD_SITE = https://github.com/charlesneimog/py4pd.git
PUREDATA_PY4PD_GIT_SUBMODULES = YES
PUREDATA_PY4PD_SITE_METHOD = git
PUREDATA_PY4PD_INSTALL_STAGING = YES
PUREDATA_PY4PD_INSTALL_TARGET = YES
PUREDATA_PY4PD_DEPENDENCIES = puredata python3 python-numpy

define PUREDATA_PY4PD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC)" LD="$(TARGET_LD)" CXX="$(TARGET_CXX)" \
		CPPFLAGS="$(TARGET_CPPFLAGS)" PYTHON_INCLUDE=$(STAGING_DIR)/usr/include/python$(PYTHON3_VERSION_MAJOR)/ \
		NUMPY_INCLUDE=$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/numpy/core/include \
		PYTHON_VERSION=python$(PYTHON3_VERSION_MAJOR) \
		PDINCLUDEDIR="$(STAGING_DIR)/usr/include/pd" \
		PDDIR="$(STAGING_DIR)/usr/lib/pd" \
		PDBINDIR="$(STAGING_DIR)/usr/lib/pd/bin" \
		-C $(@D)
endef

define PUREDATA_PY4PD_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/py4pd
	find $(@D) -type f -name "*.pd" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/py4pd/
	find $(@D) -type f -name "*.pd_linux" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/py4pd/
	find $(@D) -type f -name "*.py" -print | xargs -I{} $(INSTALL) -m 0755 \
		{} $(TARGET_DIR)/usr/local/lib/pd-externals/py4pd/
	#$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)
	#$(INSTALL) -d $(TARGET_DIR)/usr/local/lib/pd-externals/py4pd
	#$(INSTALL) $(@D)/py4pd.pd_linux $(TARGET_DIR)/usr/local/lib/pd-externals/py4pd/
endef

$(eval $(generic-package))
