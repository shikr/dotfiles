import { Gtk } from 'ags/gtk4';
import Clock from '../clock/Clock';
import Battery from '../status/Battery';
import Network from '../status/Network';
import Speaker from '../status/Speaker';

function Right() {
    return (
        <box $type="end" halign={Gtk.Align.END}>
            <button>
                <box halign={Gtk.Align.CENTER} spacing={6}>
                    <Network />
                    <Speaker />
                    <Battery />
                </box>
            </button>
            <menubutton class="clock" valign={Gtk.Align.CENTER}>
                <Clock />
                <popover
                    $={self => {
                        self.set_offset(0, 10);
                    }}
                    hasArrow={false}
                >
                    <box>
                        <Gtk.Calendar />
                    </box>
                </popover>
            </menubutton>
        </box>
    );
}

export default Right;
