################################################################################
#
# puredata-iemmatrix
#
################################################################################

PUREDATA_IEMMATRIX_VERSION = 5d33ae46d710e9f28715f86fc8937c59380d9a76
PUREDATA_IEMMATRIX_SITE = https://git.iem.at/pd/iemmatrix.git
PUREDATA_IEMMATRIX_SITE_METHOD = git
PUREDATA_IEMMATRIX_AUTORECONF = YES
PUREDATA_IEMMATRIX_INSTALL_STAGING = YES
PUREDATA_IEMMATRIX_INSTALL_TARGET = YES
PUREDATA_IEMMATRIX_DEPENDENCIES = puredata fftw-single fftw-double libsndfile

$(eval $(autotools-package))
