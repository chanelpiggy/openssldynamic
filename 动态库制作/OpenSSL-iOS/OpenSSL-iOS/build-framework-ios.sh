#!/bin/sh

#  build-framework-ios.sh
#  OpenSSL-iOS
#
#  Created by Josip Cavar on 15/07/16.
#  Modifications by @levigroker
#  Copyright © 2016 krzyzanowskim. All rights reserved.


set -e
set +u
# Avoid recursively calling this script.
if [[ $SF_MASTER_SCRIPT_RUNNING ]] ; then
	exit 0
fi
set -u
export SF_MASTER_SCRIPT_RUNNING=1

DEBUG=${DEBUG:-0}
export DEBUG
[ $DEBUG -ne 0 ] && set -x

# Fully qualified binaries (_B suffix to prevent collisions)
RM_B="/bin/rm"
CP_B="/bin/cp"
MKDIR_B="/bin/mkdir"
LIPO_B="/usr/bin/lipo"

# Constants
UNIVERSAL_OUTPUTFOLDER=${SRCROOT}/bin

# Take build target
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]] ; then
	SF_SDK_PLATFORM=${BASH_REMATCH[1]}
else
	echo "Could not find platform name from SDK_NAME: $SDK_NAME"
	exit 1
fi

if [[ "$SF_SDK_PLATFORM" != "iphoneos" ]] ; then
	echo "Please choose iPhone device as the build target."
	exit 1
fi

IPHONE_SIMULATOR_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator
IPHONE_DEVICE_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos

xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}/DependantBuilds" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIMULATOR_BUILD_DIR}" SYMROOT="${SYMROOT}" ARCHS='i386 x86_64' VALID_ARCHS='i386 x86_64' $ACTION
echo "building simulator archs done"


# Copy the framework structure to the universal folder (clean it first)
$RM_B -rf "${UNIVERSAL_OUTPUTFOLDER}"
$MKDIR_B -p "${UNIVERSAL_OUTPUTFOLDER}"
$CP_B -R "${IPHONE_DEVICE_BUILD_DIR}/${PRODUCT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/${PRODUCT_NAME}.framework"
# (we will perform the `post-build.sh` in the Scheme's Build Post-action script to copy
# the moudulemap, which is only present after the build completes).


# Build the other (non-simulator) platform

xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}/DependantBuilds" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/arm64" SYMROOT="${SYMROOT}" ENABLE_BITCODE=YES BITCODE_GENERATION_MODE=bitcode ARCHS='arm64' VALID_ARCHS='arm64' $ACTION
echo "building arm64 done"

xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}/DependantBuilds" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/armv7" SYMROOT="${SYMROOT}" ENABLE_BITCODE=YES BITCODE_GENERATION_MODE=bitcode ARCHS='armv7 armv7s' VALID_ARCHS='armv7 armv7s' $ACTION
echo "building armv7 armv7s done"


echo "111 ${IPHONE_SIMULATOR_BUILD_DIR}"
echo "222 ${IPHONE_DEVICE_BUILD_DIR}/armv7"
echo "333 ${IPHONE_DEVICE_BUILD_DIR}/arm64"
echo "444 ${UNIVERSAL_OUTPUTFOLDER}"

# Smash them together to combine all architectures
$LIPO_B -create  "${IPHONE_DEVICE_BUILD_DIR}/arm64/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" "${IPHONE_DEVICE_BUILD_DIR}/armv7/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" "${IPHONE_SIMULATOR_BUILD_DIR}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" -output "${UNIVERSAL_OUTPUTFOLDER}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}"
#注意最终输出文件路径为: /Users/chanel/dev/test/OpenSSLFramework/GRKOpenSSLFramework-master/OpenSSL-iOS/bin

echo "smashing together done"
