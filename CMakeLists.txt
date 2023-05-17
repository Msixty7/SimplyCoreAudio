cmake_minimum_required(VERSION 3.19.0)

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

add_executable(SimplyCoreAudioTest
    Tests/SimplyCoreAudioTests/main.swift
)

target_link_libraries(SimplyCoreAudioTest 
    PRIVATE
        Atomics
)

if(XCODE_VERSION VERSION_GREATER_EQUAL 12)
    set_target_properties(SimplyCoreAudioTest
        PROPERTIES
            XCODE_ATTRIBUTE_OSX_ARCHITECTURES   "x86_64;arm64;arm64e"
            XCODE_ATTRIBUTE_ARCHS               "$(ARCHS_STANDARD_64_BIT)"
    )
else()
    set_target_properties(SimplyCoreAudioTest
        PROPERTIES
            XCODE_ATTRIBUTE_OSX_ARCHITECTURES   "x86_64;i386"
            XCODE_ATTRIBUTE_ARCHS               "$(ARCHS_STANDARD_32_64_BIT)"
    )
endif()