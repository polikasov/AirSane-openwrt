include $(TOPDIR)/rules.mk

PKG_NAME:=airsaned
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/SimulPiscator/AirSane.git
PKG_SOURCE_VERSION:=a457fd63bc2137807ff88ab4bfddd11033a0a50c
PKG_MAINTAINER:=SimulPiscator
PKG_LICENSE:=GPL-3.0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/airsaned
        SECTION:=net
        CATEGORY:=Network
        DEPENDS:=+libsane +libjpeg +libpng +libavahi-client +libusb-1.0 +libstdcpp
        TITLE:=A SANE WebScan frontend that supports Apple's AirScan protocol
        URL:=https://github.com/SimulPiscator/AirSane
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
