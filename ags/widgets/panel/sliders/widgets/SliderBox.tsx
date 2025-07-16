import { Gtk } from 'ags/gtk4';
import BrightnessSlider from '../BrightnessSlider';
import SpeakerSlider from '../SpeakerSlider';

function SliderBox() {
    return (
        <box orientation={Gtk.Orientation.VERTICAL} class="vertical">
            <BrightnessSlider />
            <SpeakerSlider />
        </box>
    );
}

export default SliderBox;
