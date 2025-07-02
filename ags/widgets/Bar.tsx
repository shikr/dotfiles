import { Astal, Gdk } from 'ags/gtk4';
import app from 'ags/gtk4/app';
import Left from './modules/Left';
import Right from './modules/Right';

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return (
        <window
            visible
            name="bar"
            class="Bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={app}
        >
            <centerbox cssName="centerbox">
                <Left />
                <box $type="center" />
                <Right />
            </centerbox>
        </window>
    );
}
