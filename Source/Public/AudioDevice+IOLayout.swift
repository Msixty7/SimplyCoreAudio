//
//  AudioDevice+IOLayout.swift
//  
//
//  Created by Ruben Nine on 20/3/21.
//

import AudioToolbox.AudioServices

// MARK: - ⇄ Input/Output Layout Functions

public extension AudioDevice {
    /// Whether the device has only inputs but no outputs.
    ///
    /// - Returns: `true` when the device is input only, `false` otherwise.
    var isInputOnlyDevice: Bool {
        return channels(scope: .output) == 0 && channels(scope: .input) > 0
    }

    /// Whether the device has only outputs but no inputs.
    ///
    /// - Returns: `true` when the device is output only, `false` otherwise.
    var isOutputOnlyDevice: Bool {
        return channels(scope: .input) == 0 && channels(scope: .output) > 0
    }

    /// The number of layout channels for a given scope.
    ///
    /// - Parameter scope: A scope.
    ///
    /// - Returns: *(optional)* A `UInt32` with the number of layout channels.
    func layoutChannels(scope: Scope) -> UInt32? {
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyPreferredChannelLayout,
            mScope: propertyScope(from: scope),
            mElement: kAudioObjectPropertyElementMaster
        )

        if AudioObjectHasProperty(id, &address) {
            var result = AudioChannelLayout()
            let status = getPropertyData(address, andValue: &result)

            return noErr == status ? result.mNumberChannelDescriptions : nil
        }

        return nil
    }

    /// The number of channels for a given scope.
    ///
    /// - Parameter scope: A scope.
    ///
    /// - Returns: A `UInt32` with the number of channels.
    func channels(scope: Scope) -> UInt32 {
        guard let streams = streams(scope: scope) else { return 0 }

        return streams.map { $0.physicalFormat?.mChannelsPerFrame ?? 0 }.reduce(0, +)
    }

    /// A human readable name for the channel number and scope specified.
    ///
    /// - Parameter channel: A channel.
    /// - Parameter scope: A scope.
    ///
    /// - Returns: *(optional)* A `String` with the name of the channel.
    func name(channel: UInt32, scope: Scope) -> String? {
        guard let address = validAddress(selector: kAudioObjectPropertyElementName,
                                         scope: propertyScope(from: scope),
                                         element: channel) else { return nil }

        guard let name: String = getProperty(address: address) else { return nil }

        return name.isEmpty ? nil : name
    }

    /// Whether the audio device's jack is connected for a given scope.
    ///
    /// - Parameter scope: A scope.
    ///
    /// - Returns: `true` when jack is connected, `false` otherwise.
    func isJackConnected(scope: Scope) -> Bool? {
        if let address = validAddress(selector: kAudioDevicePropertyJackIsConnected,
                                      scope: propertyScope(from: scope))
        {
            return getProperty(address: address)
        } else {
            return nil
        }
    }
}