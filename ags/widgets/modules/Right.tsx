import { Gtk } from 'ags/gtk4';
import Clock from '../clock/Clock';
import Battery from '../status/Battery';
import Network from '../status/Network';
import Speaker from '../status/Speaker';
import Tray from '../tray/Tray';

function Right() {
    return (
        <box $type="end" class="horizontal" halign={Gtk.Align.END} spacing={4}>
            <Tray />
            <button class="raised">
                <box spacing={6} class="horizontal">
                    <Network />
                    <Speaker />
                    <Battery />
                </box>
            </button>
            <menubutton class="raised">
                <Clock />
                <popover
                    $={self => {
                        self.set_offset(0, 10);
                    }}
                    hasArrow={false}
                >
                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        class="vertical"
                    >
                        <Gtk.Calendar />
                    </box>
                </popover>
            </menubutton>
        </box>
    );
}

export default Right;
