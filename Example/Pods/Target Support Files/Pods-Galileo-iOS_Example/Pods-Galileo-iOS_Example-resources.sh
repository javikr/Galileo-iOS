#!/bin/sh
set -e
set -u
set -o pipefail

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
    # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
    # resources to, so exit 0 (signalling the script phase was successful).
    exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/025-asteroid.imageset/025-asteroid~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/025-asteroid.imageset/025-asteroid~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/025-asteroid.imageset/025-asteroid~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/101-data.imageset/101-data~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/101-data.imageset/101-data~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/101-data.imageset/101-data~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/103-doubt.imageset/103-doubt~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/103-doubt.imageset/103-doubt~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/103-doubt.imageset/103-doubt~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/107-first-aid.imageset/107-first-aid~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/107-first-aid.imageset/107-first-aid~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/107-first-aid.imageset/107-first-aid~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/188-rubbish.imageset/188-rubbish~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/188-rubbish.imageset/188-rubbish~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/188-rubbish.imageset/188-rubbish~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/200-terminal.imageset/200-terminal~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/200-terminal.imageset/200-terminal~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/200-terminal.imageset/200-terminal~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/arrow-down.imageset/arrow-down~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/arrow-down.imageset/arrow-down~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/arrow-down.imageset/arrow-down~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/iphone-clear-bg.imageset/iphone-clear-bg~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/iphone-clear-bg.imageset/iphone-clear-bg~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/iphone-clear-bg.imageset/iphone-clear-bg~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/smartphone.imageset/smartphone~universal@1x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/smartphone.imageset/smartphone~universal@2x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets/smartphone.imageset/smartphone~universal@3x.png"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Main View/View/GalileoMainViewController.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Console Log/ConsoleLogGalileoViewController.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Preferences Plugin/Preferences View/View/Cell/PreferenceBoolTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Preferences Plugin/Preferences View/View/Cell/PreferenceDateTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Preferences Plugin/Preferences View/View/Cell/PreferenceIntegerTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Preferences Plugin/Preferences View/View/Cell/PreferenceTextTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Preferences Plugin/Preferences View/View/PreferencesGalileoViewController.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/Preferences Plugin/Sources View/View/PreferencesGalileoSourcesTableViewController.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/View Flow Plugin/Cell/ViewFlowTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/View Flow Plugin/Detail/Cell/ViewFlowDetailTableViewCell.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Classes/Plugins/View Flow Plugin/Detail/ViewFlowDetailViewController.xib"
  install_resource "${PODS_ROOT}/../../Galileo-iOS/Assets/Assets.xcassets"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/Galileo-iOS/Galileo.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/Wormholy/Wormholy.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/Wormholy/Wormholy.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
