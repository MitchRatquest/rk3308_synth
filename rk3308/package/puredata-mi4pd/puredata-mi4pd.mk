################################################################################
#
# puredata-mi4pd
#
################################################################################

PUREDATA_MI4PD_VERSION = f4aa6e936347a3952c928b925a03731331d1a627
PUREDATA_MI4PD_SITE = https://github.com/TheTechnobear/Mi4Pd.git
PUREDATA_MI4PD_SITE_METHOD = git
PUREDATA_MI4PD_INSTALL_TARGET = YES
PUREDATA_MI4PD_DEPENDENCIES = puredata

$(eval $(cmake-package))
