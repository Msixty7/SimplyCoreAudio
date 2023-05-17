cmake_minimum_required(VERSION 3.25.0)

include(FetchContent)

FetchContent_Declare(
    swift-atomics
    GIT_REPOSITORY https://github.com/apple/swift-atomics.git
    GIT_TAG main
)
    
FetchContent_MakeAvailable(swift-atomics)

project(smtg-SimplyCoreAudio LANGUAGES CXX Swift)
target_include_directories(Atomics 
    INTERFACE 
        "$<TARGET_FILE_DIR:Atomics>"
#        "/Users/mmuchaier/Develop/github/Msixty7_SimplyCoreAudio/SimplyCoreAudio_build/lib/Debug"
)


add_library(SimplyCoreAudioC
    Sources/SimplyCoreAudioC/SimplyCoreAudio.c
    Sources/SimplyCoreAudioC/SimplyCoreAudio.h
    Sources/SimplyCoreAudioC/SimplyCoreAudio.swift
)

target_include_directories(SimplyCoreAudioC INTERFACE "$<TARGET_FILE_DIR:SimplyCoreAudioC>")

add_library(SimplyCoreAudio
    Sources/SimplyCoreAudio/Internal/AudioObjectPool.swift
    Sources/SimplyCoreAudio/Internal/Extensions/OSLog+Default.swift
    Sources/SimplyCoreAudio/Internal/Extensions/Bool+Extensions.swift
    Sources/SimplyCoreAudio/Internal/Extensions/AudioObject+Helpers.swift
    Sources/SimplyCoreAudio/Internal/AudioHardware.swift
    Sources/SimplyCoreAudio/Public/AudioObject.swift
    Sources/SimplyCoreAudio/Public/AudioDevice.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+VirtualMainOutput.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+DefaultDevice.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+VolumeConversion.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+ClockSource.swift
    Sources/SimplyCoreAudio/Public/Enums/Scope.swift
    Sources/SimplyCoreAudio/Public/Enums/TransportType.swift
    Sources/SimplyCoreAudio/Public/Enums/Element.swift
    Sources/SimplyCoreAudio/Public/Enums/TerminalType.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+Aggregate.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+DataSource.swift
    Sources/SimplyCoreAudio/Public/Models/VolumeInfo.swift
    Sources/SimplyCoreAudio/Public/Extensions/Notification.Name+Extensions.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+Samplerate.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+Stream.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+Latency.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+IOLayout.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+LFE.swift
    Sources/SimplyCoreAudio/Public/SimplyCoreAudio+Aggregate.swift
    Sources/SimplyCoreAudio/Public/SimplyCoreAudio.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+HogMode.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+GeneralInformation.swift
    Sources/SimplyCoreAudio/Public/AudioDevice+Channel.swift
    Sources/SimplyCoreAudio/Public/AudioStream.swift
)


target_link_libraries(SimplyCoreAudio 
    PRIVATE
        SimplyCoreAudioC
        Atomics
)

add_executable(SimplyCoreAudioTest
    Tests/SimplyCoreAudioTests/main.swift
)

target_link_libraries(SimplyCoreAudioTest 
    PRIVATE
        SimplyCoreAudio
)
