ifneq ($(TARGET_CAMERA_WRAPPER),)

LOCAL_PATH := $(call my-dir)
CAMERA_LIB := camera-$(TARGET_CAMERA_WRAPPER)
include $(call all-subdir-makefiles)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS    := optional
LOCAL_MODULE_PATH    := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE         := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_SRC_FILES      := cameraHal.cpp
LOCAL_PRELINK_MODULE := false

TARGET_GLOBAL_LD_DIRS  += -L$(LOCAL_PATH)
# LOCAL_LDLIBS := -l${CAMERA_LIB}
LOCAL_SHARED_LIBRARIES := liblog libdl libutils libcamera_client libbinder libcutils libhardware
LOCAL_SHARED_LIBRARIES += lib${CAMERA_LIB}
LOCAL_C_INCLUDES       := frameworks/base/services/ frameworks/base/include
LOCAL_C_INCLUDES       += hardware/libhardware/include/ hardware/libhardware/modules/gralloc/

include $(BUILD_SHARED_LIBRARY)

endif