import { Gtk } from 'ags/gtk4';
import PlayerList from './player/PlayerList';

function Panel() {
    return (
        <box orientation={Gtk.Orientation.VERTICAL} class="vertical">
            <PlayerList />
        </box>
    );
}

export default Panel;
