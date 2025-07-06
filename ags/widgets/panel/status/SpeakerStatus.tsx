import { createConnection } from 'ags';
import AstalWp from 'gi://AstalWp';
import Indicator from './Indicator';

const FALLBACK_ICON = 'volume-level-none';

function SpeakerStatus() {
    const wp = AstalWp.get_default()!;
    const icon = wp?.defaultSpeaker.volumeIcon ?? FALLBACK_ICON;
    const volume = wp?.defaultSpeaker.volume ?? 0;
    const conn = createConnection(
        { icon, volume },
        [
            wp.defaultSpeaker,
            'notify::volume-icon',
            () => ({
                icon: wp.defaultSpeaker.volumeIcon,
                volume: wp.defaultSpeaker.volume,
            }),
        ],
        [
            wp.defaultSpeaker,
            'notify::volume',
            () => ({
                icon: wp.defaultSpeaker.volumeIcon,
                volume: wp.defaultSpeaker.volume,
            }),
        ]
    );

    return (
        <Indicator
            iconName={conn(value => value.icon)}
            tooltip={conn(v => Math.round(v.volume * 100) + '%')}
        />
    );
}

export default SpeakerStatus;
