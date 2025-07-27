import { createBinding } from 'ags';
import { Astal, Gdk, Gtk } from 'ags/gtk4';
import app from 'ags/gtk4/app';
import MonitorContext from '../app/MonitorContext';
import { Settings } from '../utils/settings';
import Left from './modules/Left';
import Right from './modules/Right';

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
    const settings = Settings.get_default();
    const style = createBinding(settings, 'style');
    const position = createBinding(settings, 'position');

    return (
        <window
            visible
            name="bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            keymode={Astal.Keymode.ON_DEMAND}
            anchor={position(pos =>
                pos === 'top' ? TOP | LEFT | RIGHT : BOTTOM | LEFT | RIGHT
            )}
            application={app}
            cssClasses={style(style =>
                style === 'floating' ? ['transparent'] : ['toolbar']
            )}
        >
            <MonitorContext value={gdkmonitor}>
                {() => (
                    <Gtk.Frame
                        cssClasses={style(style =>
                            style === 'floating'
                                ? ['background', 'toolbar', 'floating']
                                : ['borderless']
                        )}
                    >
                        <centerbox class="horizontal">
                            <Left />
                            <box $type="center" />
                            <Right />
                        </centerbox>
                    </Gtk.Frame>
                )}
            </MonitorContext>
        </window>
    );
}
