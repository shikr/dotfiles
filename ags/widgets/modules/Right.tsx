import { Gtk } from 'ags/gtk4';
import Clock from '../clock/Clock';

function Right() {
    return (
        <box $type="end" halign={Gtk.Align.END}>
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
