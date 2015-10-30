# Post Archive Schene Script : Cocoa Touch Universal Framework
# -
# Used to create a Cocoa Touch Universal Framework.
# Modified for Xcode 7.1 by daniel@danielrodriguez.name
#
# More information (including instructions): iOS 9 Universal Cocoa Touch Frameworks: https://kodmunki.wordpress.com/2015/09/22/ios-9-universal-cocoa-touch-frameworks/

# Delete the current log.
LOG_PATH="/tmp/archive_$TARGET_NAME.log"
rm -rf $LOG_PATH
exec > $LOG_PATH 2>&1

# Set this script to terminate as soon as an exit error is different than 0 (i.e.: an error).  
# More information about the 'set' command: http://www.computerhope.com/unix/uset.htm
set -e

# # The following is a quick hack that allows this script to find the correct DEVICE_BIN path.
# XCODE_71_DEVICE_BIN_SUFFIX="iphoneos/"
# DEVICE_BIN="${OBJROOT}/UninstalledProducts/${XCODE_71_DEVICE_BIN_SUFFIX}${TARGET_NAME}.framework"

BUILD_INTERMEDIATES="${OBJROOT}"
BUILD_PRODUCTS="${SYMROOT}/../../../../Products"
SIMULATOR_BIN_PREFIX="Debug-iphonesimulator"
DEVICE_BIN="${BUILD_INTERMEDIATES}/UninstalledProducts/iphoneos/${TARGET_NAME}.framework"
SIMULATOR_BIN="${BUILD_PRODUCTS}/${SIMULATOR_BIN_PREFIX}/${TARGET_NAME}.framework"

# Try to recover from SIMULATOR_BIN not existing.
if [ -d "${SIMULATOR_BIN}" ]; then
	echo "" # empty log ensures that script compiles.
else
	BUILD_PRODUCTS="${SRCROOT}/Build/Products"	
	SIMULATOR_BIN="${BUILD_PRODUCTS}/${SIMULATOR_BIN_PREFIX}/${TARGET_NAME}.framework"
fi

ARCHIVE_PATH="${SRCROOT}/_Archive"
rm -rf "${ARCHIVE_PATH}"
mkdir "${ARCHIVE_PATH}"

# Only proceed if we are in Release configuration
if [ "${CONFIGURATION}" = "Release" ]; then

	echo "\nArchiving $TARGET_NAME. will attempt to copy \$DEVICE_BIN TO \$DEVICE_PATH\n"

	# Only proceed if DEVICE_BIN EXISTS
	if [ -d "${DEVICE_BIN}" ]; then
		DEVICE_PATH="${ARCHIVE_PATH}/Release"
		mkdir "${DEVICE_PATH}"
		cp -r "${DEVICE_BIN}" "${DEVICE_PATH}"
	else
		# DEVICE_BIN doesn't exists.  Log the error and exit.
		ERROR_DESC="DEVICE_BIN (a path on your system) ($DEVICE_BIN) doesn't exist."
		ERROR_REASON="This can happen due to the XCODE_71_DEVICE_BIN_SUFFIX hack not working anymore, or because you're not using Xcode Version 7.1 (7B91b)"
		echo "\nArchiving $TARGET_NAME. ERROR!!! - $ERROR_DESC  $ERROR_REASON\n"
		exit -1;
	fi

	echo "\nArchiving $TARGET_NAME. will attempt to copy \$SIMULATOR_BIN TO \$SIMULATOR_PATH\n"

	# Only proceed if SIMULATOR_BIN exists
	if [ -d "${SIMULATOR_BIN}" ]; then
		SIMULATOR_PATH="${ARCHIVE_PATH}/Debug"
		mkdir "${SIMULATOR_PATH}"
		cp -r "${SIMULATOR_BIN}" "${SIMULATOR_PATH}"

		echo "\nArchiving $TARGET_NAME. will run lipo to create FAT binary from libraries in \$SIMULATOR_PATH and \$DEVICE_PATH.\n"

		# Create our Universal Cocoa Touch Framework by joining the simulator and device frameworks.
		lipo -create "${DEVICE_BIN}/${TARGET_NAME}" "${SIMULATOR_BIN}/${TARGET_NAME}" -output "${SIMULATOR_PATH}/${TARGET_NAME}.framework/${TARGET_NAME}"
	else
		# SIMULATOR BIN doesn't exists.  Log the error and exit.
		ERROR_DESC="SIMULATOR_BIN [$SIMULATOR_BIN] doesn't exist."
		ERROR_REASON="This can happen due to changes to your .xcodeproj variables, or because you're not using Xcode Version 7.1 (7B91b)"
		echo "\nArchiving $TARGET_NAME. ERROR!!! - $ERROR_DESC  $ERROR_REASON\n"
		exit -1;
	fi
else
	# CONFIGURATION is not "Release". Log the error and exit
	ERROR_DESC="The \"current archive run\" is not the Release Configuration. ( Technically, if [ -d $CONFIGURATION == \"Release\" ] evaluated to FALSE)"
	ERROR_REASON="The current \$CONFIGURATION is [$CONFIGURATION].  Check the current Scheme and try again."
	echo "\nArchiving $TARGET_NAME. ERROR!!! - $ERROR_DESC  $ERROR_REASON\n"
	exit -1;
fi

echo "\n SUCCESS! Cocoa Touch Universal Framework(s) for ${TARGET_NAME} available at [${ARCHIVE_PATH}]"

exit 0;
