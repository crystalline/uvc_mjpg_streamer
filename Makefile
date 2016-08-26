#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uvc_mjpg_streamer
PKG_VERSION:=1.0.0
PKG_RELEASE:=5
PKG_MAINTAINER:=Crystalline Emerald
PKG_LICENSE:=GPL-2
PKG_CONFIG_DEPENDS:=libjpeg libpthread

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=MJPG_STREAMER_V4L2:libv4l

TARGET_LDFLAGS+= \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib/libjpeg/lib

define Package/uvc_mjpg_streamer
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+libpthread +libjpeg +MJPG_STREAMER_V4L2:libv4l
  TITLE:=Simplified single-file mjpg-streamer
  URL:=""
  MENU:=1
endef

define Package/uvc_mjpg_streamer/description
 Simplified single-file mjpg-streamer
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(TARGET_CONFIGURE_OPTS)
endef

define Package/uvc_mjpg_streamer/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/uvc_mjpg_streamer $(1)/bin/
	$(INSTALL_DIR) $(1)/www/webcam
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/* $(1)/www/webcam/
endef

$(eval $(call BuildPackage,uvc_mjpg_streamer))