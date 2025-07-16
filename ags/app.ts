import app from 'ags/gtk4/app';
import { execAsync } from 'ags/process';
import Gio from 'gi://Gio';
import style from './style.scss';
import Bar from './widgets/Bar';
import NotificationWindow from './widgets/notification/NotificationWindow';

const windows = [Bar, NotificationWindow];

app.start({
    css: style,
    main() {
        const shutdownAction = new Gio.SimpleAction({ name: 'shutdown' });
        const rebootAction = new Gio.SimpleAction({ name: 'reboot' });

        shutdownAction.connect('activate', () => execAsync('poweroff'));
        rebootAction.connect('activate', () => execAsync('reboot'));

        app.add_action(shutdownAction);
        app.add_action(rebootAction);

        app.get_monitors().forEach(m => windows.forEach(win => win(m)));
    },
});
