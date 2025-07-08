################################################################################
#
# python-peewee
#
################################################################################

PYTHON_PEEWEE_VERSION = 3.18.1
PYTHON_PEEWEE_SITE = https://github.com/coleifer/peewee.git
PYTHON_PEEWEE_SITE_METHOD = git
PYTHON_PEEWEE_SETUP_TYPE = setuptools
PYTHON_PEEWEE_LICENSE = MIT
PYTHON_PEEWEE_LICENSE_FILES = LICENSE

$(eval $(python-package))
