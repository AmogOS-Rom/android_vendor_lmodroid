# Copyright (C) 2020 The PixelExperience Project
# Copyright (C) 2020 The LibreMobileOS Foundation
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

# Customer version settings

# Customer version variable name
# Default: LMODROID_BUILD_NAME
CUSTOMER_VERSION_VAR_NAME := LMODROID_BUILD_NAME

DATE_YEAR := $(shell date -u +%Y)
DATE_MONTH := $(shell date -u +%m)
DATE_DAY := $(shell date -u +%d)
ifeq ($(APPEND_BUILD_DATE),true)
    DATE_HOUR := $(shell date -u +%H)
    DATE_MINUTE := $(shell date -u +%M)
    BUILD_DATE := $(DATE_YEAR)$(DATE_MONTH)$(DATE_DAY)-$(DATE_HOUR)$(DATE_MINUTE)
else
    BUILD_DATE := $(DATE_YEAR)$(DATE_MONTH)$(DATE_DAY)
endif

# Vanilla
LMO_EXTRAVERSION :=

# FOSS
ifeq ($(GAPPS),false)
    WITH_GMS := true
    LMO_EXTRAVERSION := FOSS-
endif

# Chocolate
ifeq ($(GAPPS),true)
    $(GAPPS will be included in the build)
    LMO_EXTRAVERSION := GAPPS-
    ifeq ($(GAPPS_ARM32),)
        $(warning GAPPS_ARM32 is not set, it defaulting to 64 bit)
        $(warning Dont try to set it, only needed for 32 bit devices)
        $(call inherit-product, vendor/gapps/arm64/arm64-vendor.mk)
    endif
    ifeq ($(GAPPS_ARM32), false)
        $(warning including 32 bit gapps)
        $(call inherit-product, vendor/gapps/arm/arm-vendor.mk)
    endif
endif

LMODROID_VERSION ?= 1.0
LMODROID_NAME ?= AmogOS-ROM
LMODROID_BUILD_NAME := $(LMODROID_NAME)-$(LMODROID_VERSION)-$(LMO_EXTRAVERSION)$(BUILD_DATE)-$(LMODROID_BUILD)

LMODROID_PROPERTIES := \
    ro.lmodroid.build_name=$(LMODROID_BUILD_NAME) \
    ro.lmodroid.build_date=$(BUILD_DATE) \
    ro.lmodroid.build_type=$(LMODROID_BUILDTYPE) \
    ro.lmodroid.version=$(LMODROID_VERSION)
