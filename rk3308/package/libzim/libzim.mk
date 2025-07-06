################################################################################
#
# libzim
#
################################################################################
LIBZIM_VERSION = 9.3.0
LIBZIM_SITE = $(call github,openzim,libzim,$(LIBZIM_VERSION))
LIBZIM_INSTALL_STAGING = YES

$(eval $(meson-package))
