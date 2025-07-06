################################################################################
#
# libzim
#
################################################################################
LIBZIM_VERSION = 9.3.0
LIBZIM_SITE = $(call github,openzim,libzim,$(LIBZIM_VERSION))
LIBZIM_INSTALL_STAGING = YES
LIBZIM_DEPENDENCIES = icu zstd xapian

$(eval $(meson-package))
