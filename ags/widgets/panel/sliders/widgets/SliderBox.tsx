import { Gtk } from 'ags/gtk4';
import SpeakerSlider from '../SpeakerSlider';

function SliderBox() {
    return (
        <box orientation={Gtk.Orientation.VERTICAL} class="vertical">
            <SpeakerSlider />
        </box>
    );
}

export default SliderBox;
