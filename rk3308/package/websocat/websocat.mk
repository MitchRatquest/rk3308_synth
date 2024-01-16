################################################################################
#
# websocat
#
################################################################################

WEBSOCAT_VERSION = 1.12.0
WEBSOCAT_SITE = $(call github,vi,websocat,v$(WEBSOCAT_VERSION))
WEBSOCAT_LICENSE = Apache-2.0 or MIT
WEBSOCAT_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

$(eval $(cargo-package))

