# Build the unit tests.
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := ResourceManagerService_test

LOCAL_MODULE_TAGS := tests

LOCAL_SRC_FILES := \
  ResourceManagerService_test.cpp \

LOCAL_SHARED_LIBRARIES := \
  libbinder \
  liblog \
  libmedia \
  libresourcemanagerservice \
  libutils \

LOCAL_C_INCLUDES := \
  frameworks/av/include \
  frameworks/av/services/mediaresourcemanager \

LOCAL_32_BIT_ONLY := true

include $(BUILD_NATIVE_TEST)
