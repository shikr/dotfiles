import { Astal, Gdk, Gtk } from 'ags/gtk4';
import app from 'ags/gtk4/app';
import Left from './modules/Left';
import Right from './modules/Right';

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return (
        <window
            visible
            name="bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={app}
        >
            <Gtk.Frame cssClasses={['background', 'toolbar']}>
                <centerbox class="horizontal">
                    <Left />
                    <box $type="center" />
                    <Right />
                </centerbox>
            </Gtk.Frame>
        </window>
    );
}
