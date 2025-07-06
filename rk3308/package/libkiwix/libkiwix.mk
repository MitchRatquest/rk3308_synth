################################################################################
#
# libkiwix
#
################################################################################
LIBKIWIX_VERSION = 14.0.0
LIBKIWIX_SITE = $(call github,kiwix,libkiwix,$(LIBKIWIX_VERSION))
LIBKIWIX_INSTALL_STAGING = YES
LIBKIWIX_DEPENDENCIES = icu pugixml mustache libcurl microhttpd zlib libzim

$(eval $(meson-package))
