################################################################################
#
# python-pychord
#
################################################################################

PYTHON_PYCHORD_VERSION = 0.6.3
PYTHON_PYCHORD_SOURCE = pychord-$(PYTHON_PYCHORD_VERSION).tar.gz
PYTHON_PYCHORD_SITE = https://files.pythonhosted.org/packages/2a/53/ea2c2811e037c06ee5ad1d44aac9c4876fde0d1c0cea448e3d2ad2e4ae46
PYTHON_PYCHORD_SETUP_TYPE = setuptools
PYTHON_PYCHORD_LICENSE = BSD-3-Clause
PYTHON_PYCHORD_LICENSE_FILES = LICENSE

$(eval $(python-package))
