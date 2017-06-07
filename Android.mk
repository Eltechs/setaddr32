LOCAL_PATH:= $(call my-dir)

setaddr32_common_shared_libs := \
    libc \
    liblog

setaddr32_src_files := \
    setaddr32.cpp \

setaddr32_cflags := \
    -Wall -Werror -Wunused -Wunreachable-code

setaddr32_ldflags_64 := \
    -Wl,--export-dynamic

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(setaddr32_src_files)

LOCAL_LDFLAGS_64 := $(setaddr32_ldflags_64)

LOCAL_SHARED_LIBRARIES := $(setaddr32_common_shared_libs)

LOCAL_WHOLE_STATIC_LIBRARIES := $(setaddr32_common_static_libs)

LOCAL_MODULE:= setaddr32
LOCAL_MULTILIB := 64

LOCAL_CFLAGS += $(setaddr32_cflags)

# In SANITIZE_LITE mode, we create the sanitized binary in a separate location (but reuse
# the same module). Using the same module also works around an issue with make: binaries
# that depend on sanitized libraries will be relinked, even if they set LOCAL_SANITIZE := never.
#
# Also pull in the asanwrapper helper.
ifeq ($(SANITIZE_LITE),true)
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)/asan
LOCAL_REQUIRED_MODULES := asanwrapper
endif

include $(BUILD_EXECUTABLE)
