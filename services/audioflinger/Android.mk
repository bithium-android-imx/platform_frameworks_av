# @@DOLBY_BANNER
#
# This file was modified by Dolby Laboratories, Inc. The portions of the
# code that are surrounded by "DOLBY..." are copyrighted and 
# licensed separately, as follows:
#
#  (C) 2012 Dolby Laboratories, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @@DOLBY_FILE_X
# @@DOLBY_FILE_R
# @@DOLBY_BANNER_END
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    ISchedulingPolicyService.cpp \
    SchedulingPolicyService.cpp

# FIXME Move this library to frameworks/native
LOCAL_MODULE := libscheduling_policy

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=               \
    AudioFlinger.cpp            \
    AudioMixer.cpp.arm          \
    AudioResampler.cpp.arm      \
    AudioPolicyService.cpp      \
    ServiceUtilities.cpp        \
    AudioResamplerSinc.cpp.arm

# uncomment to enable AudioResampler::MED_QUALITY
# LOCAL_SRC_FILES += AudioResamplerCubic.cpp.arm

LOCAL_SRC_FILES += StateQueue.cpp

# uncomment for debugging timing problems related to StateQueue::push()
LOCAL_CFLAGS += -DSTATE_QUEUE_DUMP

LOCAL_C_INCLUDES := \
    $(call include-path-for, audio-effects) \
    $(call include-path-for, audio-utils)

# FIXME keep libmedia_native but remove libmedia after split
LOCAL_SHARED_LIBRARIES := \
    libaudioutils \
    libcommon_time_client \
    libcutils \
    libutils \
    libbinder \
    libmedia \
    libmedia_native \
    libnbaio \
    libhardware \
    libhardware_legacy \
    libeffects \
    libdl \
    libpowermanager

LOCAL_STATIC_LIBRARIES := \
    libscheduling_policy \
    libcpustats \
    libmedia_helper

LOCAL_MODULE:= libaudioflinger

LOCAL_SRC_FILES += FastMixer.cpp FastMixerState.cpp

LOCAL_CFLAGS += -DFAST_MIXER_STATISTICS

# uncomment to display CPU load adjusted for CPU frequency
# LOCAL_CFLAGS += -DCPU_FREQUENCY_STATISTICS

LOCAL_CFLAGS += -DSTATE_QUEUE_INSTANTIATIONS='"StateQueueInstantiations.cpp"'

LOCAL_CFLAGS += -UFAST_TRACKS_AT_NON_NATIVE_SAMPLE_RATE

# uncomment for systrace
# LOCAL_CFLAGS += -DATRACE_TAG=ATRACE_TAG_AUDIO

# uncomment for dumpsys to write most recent audio output to .wav file
# 47.5 seconds at 44.1 kHz, 8 megabytes
# LOCAL_CFLAGS += -DTEE_SINK_FRAMES=0x200000

# uncomment to enable the audio watchdog
# LOCAL_SRC_FILES += AudioWatchdog.cpp
# LOCAL_CFLAGS += -DAUDIO_WATCHDOG

ifdef DOLBY_DAP
#ifdef DOLBY_DAP_DSP
    LOCAL_CFLAGS += -DDOLBY_DAP_QDSP
#endif
endif # DOLBY_DAP END

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
