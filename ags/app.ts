import app from 'ags/gtk4/app';
import style from './style.scss';
import Bar from './widgets/Bar';
import NotificationWindow from './widgets/notification/NotificationWindow';

const windows = [Bar, NotificationWindow];

app.start({
    css: style,
    main() {
        app.get_monitors().forEach(m => windows.forEach(win => win(m)));
    },
});
