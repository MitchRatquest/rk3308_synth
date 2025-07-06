################################################################################
#
# kiwix-tools
#
################################################################################
KIWIX_TOOLS_VERSION = 3.7.0
KIWIX_TOOLS_SITE = $(call github,kiwix,kiwix-tools,$(KIWIX_TOOLS_VERSION))
KIWIX_TOOLS_DEPENDENCIES = libzim libkiwix

$(eval $(meson-package))
