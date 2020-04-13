#
# Copyright (C) 2006-2016 OpenWrt.org
# Copyright (C) 2016 lede-project.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=airsaned
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/SimulPiscator/AirSane.git
PKG_SOURCE_VERSION:=a457fd63bc2137807ff88ab4bfddd11033a0a50c
PKG_MIRROR_HASH:=01490d7805dcff55eee316ca06388706aefd3284cdcf1a52bc3dd4fb4f1dba62
PKG_MAINTAINER:=SimulPiscator <example@example.com>
PKG_LICENSE:=GPL-3.0
PKG_INSTALL:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/airsaned
  TITLE:=A SANE WebScan frontend that supports Apple's AirScan protocol
  URL:=https://github.com/SimulPiscator/AirSane
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libsane +libjpeg +libpng +libavahi-client +libusb-1.0 +libstdcpp
endef

define Package/airsaned/description
  A SANE WebScan frontend that supports Apple's AirScan protocol
endef

define Build/Patch
	patch ./imageformats/pngencoder.cpp patches/001-png.patch
endef

define Build/Prepare
	$(Build/Patch)
	mkdir -p $(PKG_BUILD_DIR)
	cmake -DCMAKE_C_COMPILER=$(TARGET_CC) -DCMAKE_CXX_COMPILER=$(TARGET_CXX) -B $(PKG_BUILD_DIR)
endef

define Build/Compile
	(cd $(PKG_BUILD_DIR); make)
endef

define Package/airsaned/install 
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/airsaned $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/airsaned.init $(1)/etc/init.d/airsaned
endef

$(eval $(call BuildPackage,airsaned))
