import { Gtk } from 'ags/gtk4';
import ButtonBox from './buttons/widgets/ButtonBox';
import PlayerList from './player/PlayerList';

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
        </box>
    );
}

export default Panel;
