ifeq ($(TARGET_DZO_CAMERA),true)

# When zero we link against libmmcamera; when 1, we dlopen libmmcamera.
DLOPEN_LIBMMCAMERA:=1

ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CFLAGS:= -DDLOPEN_LIBMMCAMERA=$(DLOPEN_LIBMMCAMERA)

LOCAL_CFLAGS+= -DHW_ENCODE

LOCAL_HAL_FILES := QualcommCamera.cpp QualcommCameraHardware.cpp

LOCAL_C_INCLUDES += \
        frameworks/base/services/camera/libcameraservice #

LOCAL_SRC_FILES := $(LOCAL_HAL_FILES)

#ifeq ($(TARGET_HARDWARE_3D),true)
#  LOCAL_CFLAGS += -DCAMERA_3D
#endif

LOCAL_CFLAGS+= -DNUM_PREVIEW_BUFFERS=4 -D_ANDROID_

# To Choose neon/C routines for YV12 conversion
LOCAL_CFLAGS+= -DUSE_NEON_CONVERSION
# Uncomment below line to enable smooth zoom
#LOCAL_CFLAGS+= -DCAMERA_SMOOTH_ZOOM

LOCAL_C_INCLUDES += hardware/qcom/display/libgralloc \
                    hardware/qcom/display/libgenlock \
                    hardware/qcom/media/libstagefrighthw

LOCAL_SHARED_LIBRARIES:= libutils libui libcamera_client liblog libcutils libmmjpeg

LOCAL_SHARED_LIBRARIES+= libgenlock libbinder
LOCAL_SHARED_LIBRARIES+= libdl

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE:= camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif # BUILD_TINY_ANDROID
endif # TARGET_DZO_CAMERA
