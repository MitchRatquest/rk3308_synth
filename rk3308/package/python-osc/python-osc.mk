################################################################################
#
# python-osc
#
################################################################################

PYTHON_OSC_VERSION = v1.7.7
PYTHON_OSC_SITE = https://github.com/attwad/python-osc.git
PYTHON_OSC_SITE_METHOD = git
PYTHON_OSC_SETUP_TYPE = setuptools
PYTHON_OSC_LICENSE = BSD-3-Clause
PYTHON_OSC_LICENSE_FILES = LICENSE

$(eval $(python-package))
