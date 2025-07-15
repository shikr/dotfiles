import { createBinding } from 'ags';
import AstalWp from 'gi://AstalWp';
import Slider from './widgets/Slider';

function SpeakerSlider() {
    const speaker = AstalWp.get_default()!.defaultSpeaker;
    const volume = createBinding(speaker, 'volume');

    return (
        <Slider
            startWidget={
                <button
                    iconName={createBinding(speaker, 'volumeIcon')}
                    onClicked={() => (speaker.mute = !speaker.mute)}
                />
            }
            min={0}
            max={1}
            value={volume}
            label={volume(v => Math.round(v * 100) + '%')}
            updateValue={value => speaker.set_volume(value)}
        />
    );
}

export default SpeakerSlider;
