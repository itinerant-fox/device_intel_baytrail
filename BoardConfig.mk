#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the non-open-source parts, if they're present
-include vendor/intel/baytrail/BoardConfigVendor.mk

# The generic product target doesn't have any hardware-specific pieces.

TARGET_BOARD_PLATFORM := android-x86

TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64
TARGET_PRELINK_MODULE := false

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86

TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI) $(TARGET_CPU_ABI2) $(NATIVE_BRIDGE_ABI_LIST_64_BIT)
TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_2ND_CPU_ABI) $(TARGET_2ND_CPU_ABI2) $(NATIVE_BRIDGE_ABI_LIST_32_BIT)
TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI_LIST_64_BIT) $(TARGET_CPU_ABI_LIST_32_BIT)

TARGET_USES_64_BIT_BINDER := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_USE_LEGACY_UI := true

BOARD_SYSTEMIMAGE_PARTITION_SIZE = $(if $(MKSQUASHFS),0,1073741824)

# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# Enable dex-preoptimization to speed up the first boot sequence
# of an SDK AVD. Note that this operation only works on Linux for now
ifeq ($(HOST_OS),linux)
WITH_DEXPREOPT := true
TARGET_GCC_VERSION_EXP := 4.9
endif

# the following variables could be overridden
TARGET_PRELINK_MODULE := false
TARGET_NO_KERNEL ?= false
TARGET_NO_RECOVERY ?= true

#Not needed?
#TARGET_EXTRA_KERNEL_MODULES := tp_smapi

ifneq ($(filter efi_img,$(MAKECMDGOALS)),)
TARGET_KERNEL_ARCH ?= x86_64
endif

# Don't build emulator
BUILD_EMULATOR ?= false
BUILD_STANDALONE_EMULATOR ?= false
BUILD_EMULATOR_QEMUD ?= false
BUILD_EMULATOR_OPENGL ?= false
BUILD_EMULATOR_OPENGL_DRIVER ?= false
BUILD_EMULATOR_QEMU_PROPS ?= false
BUILD_EMULATOR_CAMERA_HAL ?= false
BUILD_EMULATOR_GPS_MODULE ?= false
BUILD_EMULATOR_LIGHTS_MODULE ?= false
BUILD_EMULATOR_SENSORS_MODULE ?= false

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser


BOARD_KERNEL_CMDLINE := root=/dev/ram0 androidboot.hardware=$(TARGET_PRODUCT)


#Wireless

BOARD_WIFI_VENDOR: = realtek
ifeq ($ (BOARD_WIFI_VENDOR), realtek)
	WPA_SUPPLICANT_VERSION: = VER_0_8_X
	BOARD_WPA_SUPPLICANT_DRIVER: = NL80211
	BOARD_WPA_SUPPLICANT_PRIVATE_LIB: = lib_driver_cmd_rtl
	BOARD_HOSTAPD_DRIVER: = NL80211
	BOARD_HOSTAPD_PRIVATE_LIB: = Lib_driver_cmd_rtl
	SW_BOARD_USR_WIFI: = rtl8723bs
	BOARD_WLAN_DEVICE: = rtl8723bs
endif


#Bluetooth

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_BCM: = true
BOARD_HAVE_BLUETOOTH_RTK: = true
BLUETOOTH_HCI_USE_RTK_H5: = true
SW_BOARD_HAVE_BLUETOOTH_NAME: = rtl8723bs
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/baytrail/bluetooth
#BLUETOOTH_HCI_USE_USB := true


#Graphics

#BOARD_GPU_DRIVERS ?= i915 i965 ilo r300g r600g nouveau vmwgfx
#No Radeon Drivers Required
#BOARD_GPU_DRIVERS ?= i915 i965 swrast r300g r600g
BOARD_GPU_DRIVERS ?= i915 i965 swrast
ifneq ($(strip $(BOARD_GPU_DRIVERS)),)
TARGET_HARDWARE_3D := true
BOARD_EGL_CFG ?= device/intel/baytrail/gpu/egl_mesa.cfg
endif

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS ?= 3

BOARD_USE_LIBVA_INTEL_DRIVER := true
BOARD_USE_LIBVA := true
BOARD_USE_LIBMIX := true
BOARD_USES_WRS_OMXIL_CORE := true
USE_INTEL_OMX_COMPONENTS := true



#Camera


USE_CAMERA_STUB ?= false


#Audio

#Disable Audio Stub
BOARD_USES_GENERIC_AUDIO ?= false
BOARD_USES_ALSA_AUDIO ?= true
BUILD_WITH_ALSA_UTILS ?= true


#GPS

#No GPS for Notion Ink
BOARD_HAS_GPS_HARDWARE ?= false

