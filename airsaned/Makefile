PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/SimulPiscator/AirSane.git
PKG_MIRROR_HASH:=01490d7805dcff55eee316ca06388706aefd3284cdcf1a52bc3dd4fb4f1dba62
PKG_SOURCE_VERSION:=a457fd63bc2137807ff88ab4bfddd11033a0a50c
PKG_MAINTAINER:=SimulPiscator <example@example.com>
PKG_LICENSE:=GPL-3.0
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
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
	patch --merge $(PKG_BUILD_DIR)/imageformats/pngencoder.cpp -i ./patches/001-png.patch
endef

define Build/Prepare
	$(Build/Prepare/Default)
	$(Build/Patch)
	mkdir -p $(PKG_BUILD_DIR)/build
	cmake -DCMAKE_C_COMPILER=$(TARGET_CC) -DCMAKE_CXX_COMPILER=$(TARGET_CXX) -B $(PKG_BUILD_DIR)/build -S $(PKG_BUILD_DIR)
endef

define Build/Compile
        (cd $(PKG_BUILD_DIR)/build; make)
endef

define Package/airsaned/install 
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/airsaned $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/airsaned.init $(1)/etc/init.d/airsaned
endef

$(eval $(call BuildPackage,airsaned))
