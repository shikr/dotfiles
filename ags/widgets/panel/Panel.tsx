import { Gtk } from 'ags/gtk4';
import ButtonBox from './buttons/widgets/ButtonBox';
import PlayerList from './player/PlayerList';
import SliderBox from './sliders/widgets/SliderBox';

function Panel() {
    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
            class="vertical"
            spacing={6}
        >
            <ButtonBox />
            <Gtk.Separator class="spacer" />
            <PlayerList />
            <Gtk.Separator class="spacer" />
            <SliderBox />
        </box>
    );
}

export default Panel;
